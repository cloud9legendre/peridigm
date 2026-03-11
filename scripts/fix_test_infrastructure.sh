#!/bin/sh
# fix_test_infrastructure.sh
# This script repairs two Windows checkout problems in the Peridigm test tree:
#
#   1. Symlink stub files: On Windows (core.symlinks=false), git checks out
#      symlinks as tiny text files containing the target path (e.g. "../TestName.g").
#      This script detects files <= 60 bytes that contain a relative path and
#      converts them to real Linux symlinks.
#
#   2. CRLF line endings: .comp comparison files checked out on Windows have
#      \r\n endings that exodiff on Linux cannot parse.
#      This script strips all \r characters from .comp files.

set -e

TEST_DIR="${1:-/peridigm/test}"

echo "=== Restoring symlinks in $TEST_DIR ==="
find "$TEST_DIR" -type f | while IFS= read -r filepath; do
    size=$(wc -c < "$filepath" 2>/dev/null || echo 999)
    if [ "$size" -le 150 ]; then
        target=$(tr -d '\r\n' < "$filepath" 2>/dev/null)
        # Only act if target looks like a relative path (starts with ../)
        case "$target" in
            ../*|./*) ;;
            *) continue ;;
        esac
        dir=$(dirname "$filepath")
        # Verify the symlink target would actually exist
        if [ -e "$dir/$target" ]; then
            echo "  Restoring: $filepath -> $target"
            rm "$filepath"
            ln -s "$target" "$filepath"
        fi
    fi
done

echo "=== Fixing CRLF in .comp files ==="
find "$TEST_DIR" -type f \( -name "*.comp" -o -name "*.txt" -o -name "*.xml" \) | while IFS= read -r f; do
    echo "  Fixing CRLF: $f"
    sed -i 's/\r//' "$f"
done

echo "=== Test infrastructure repair complete ==="
