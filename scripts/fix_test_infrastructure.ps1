<#
.SYNOPSIS
    Repairs Windows-checkout issues in the Peridigm test tree.

.DESCRIPTION
    On Windows with core.symlinks=false (the default), git checks out symlinks as
    tiny plain-text stub files containing the relative target path.  This script
    detects those stub files and converts them to real NTFS junctions/symlinks so
    that the test tree is self-consistent on Linux (via WSL or Docker bind-mounts).

    Two problems are repaired:
      1. Symlink stubs  — files <= 150 bytes whose content is a relative path
                          (starting with "../" or "./") are re-created as proper
                          symbolic links using New-Item -ItemType SymbolicLink.
      2. CRLF endings   — .comp, .txt, and .xml files used by exodiff are
                          converted from CRLF to LF so that the Linux exodiff
                          tool can parse them correctly.

.PARAMETER TestDir
    Root directory of the Peridigm test tree (default: .\test).

.EXAMPLE
    .\fix_test_infrastructure.ps1
    .\fix_test_infrastructure.ps1 -TestDir C:\peridigm\test

.NOTES
    Administrator privileges are required to create symbolic links on Windows
    unless Developer Mode is enabled (Settings > Update & Security > Developer Mode).
    Run PowerShell as Administrator, or enable Developer Mode before running.
#>

[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Position = 0)]
    [ValidateScript({ Test-Path $_ -PathType Container })]
    [string]$TestDir = (Join-Path $PSScriptRoot '..\test')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$TestDir = Resolve-Path $TestDir

Write-Host "=== Restoring symlinks in $TestDir ===" -ForegroundColor Cyan

Get-ChildItem -Path $TestDir -File -Recurse | ForEach-Object {
    $file = $_

    # Only inspect small files — symlink stubs are tiny (< 150 bytes)
    if ($file.Length -gt 150) { return }

    try {
        $content = [System.IO.File]::ReadAllText($file.FullName).Trim().Replace("`r", '').Replace("`n", '')
    } catch {
        return  # Skip unreadable files
    }

    # Only act if the content looks like a relative path
    if ($content -notmatch '^(\.\./|\./)') { return }

    $targetPath = Join-Path $file.DirectoryName $content

    if (-not (Test-Path $targetPath)) {
        Write-Verbose "  Skipping (target missing): $($file.FullName) -> $content"
        return
    }

    if ($PSCmdlet.ShouldProcess($file.FullName, "Replace stub with symlink -> $content")) {
        Write-Host "  Restoring: $($file.FullName) -> $content" -ForegroundColor Yellow
        Remove-Item -LiteralPath $file.FullName -Force
        New-Item -ItemType SymbolicLink -Path $file.FullName -Target $content | Out-Null
    }
}

Write-Host "`n=== Fixing CRLF in .comp / .txt / .xml files ===" -ForegroundColor Cyan

Get-ChildItem -Path $TestDir -Recurse -Include '*.comp', '*.txt', '*.xml' | ForEach-Object {
    $file = $_
    if ($PSCmdlet.ShouldProcess($file.FullName, 'Strip CRLF')) {
        Write-Verbose "  Fixing CRLF: $($file.FullName)"
        $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
        # Remove all carriage-return bytes (0x0D)
        $stripped = $bytes | Where-Object { $_ -ne 0x0D }
        [System.IO.File]::WriteAllBytes($file.FullName, [byte[]]$stripped)
    }
}

Write-Host "`n=== Test infrastructure repair complete ===" -ForegroundColor Green
