# Changelog

All notable changes to Peridigm are documented here.  
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [Unreleased]

### Added
- `scripts/fix_test_infrastructure.ps1` — PowerShell equivalent of the existing
  `.sh` repair script for Windows developers (`core.symlinks=false` checkouts)
- `KNOWN_ISSUES.md` — documents confirmed test failures and known infrastructure
  issues (`MultipleHorizons` NP=1 crash, `MultipleOutputFiles` exodiff mismatch)
- CMake `fix-test-infra` custom target: `cmake --build . --target fix-test-infra`
  restores Windows-checkout symlink stubs and strips CRLF from comparison files
- Configure-time CMake `WARNING` when `ALBANY_SEACAS` is not set
- GitHub Actions: `lint` job (cppcheck static analysis) runs ahead of the build job
- GitHub Actions: Docker Hub push gated to `master` branch only; PRs build-only
- GitHub Actions: production image tagged with commit SHA for traceability
- Docker layer caching in CI (`cache-from`/`cache-to` inline)
- Unit tests for `src/damage/` — `CriticalStretchDamageModel`
  (construction, no-damage, full-damage, partial-damage cases)
- Unit tests for `src/contact/` — `ShortRangeForceContactModel`
  (construction, no-contact, repulsive-contact cases)

### Changed
- `CMakeLists.txt` — minimum required CMake version bumped from **3.3 to 3.8**
  (required for native C++17 `CMAKE_CXX_STANDARD` support)
- `CMakeLists.txt` — `BlasLapack_Libraries` variable corrected (`${blas}` →
  `${Blas_LIBRARY}`); previously always resolved to an empty string
- `CMakeLists.txt` — `yaml-cpp` detection now properly conditional on
  `Trilinos_TPL_LIST` instead of always forcing `HAVE_YAML=TRUE`
- `CMakeLists.txt` — SEACAS tool symlinks use cross-platform
  `file(CREATE_LINK ... SYMBOLIC)` instead of Unix-only `execute_process(ln -sf)`
- `CMakeLists.txt` — `USE_DAKOTA` option now emits a `cmake WARNING` when enabled
  (the option was previously declared but not wired to any build targets)
- `.github/workflows/test.yml` — all action pins upgraded to current major versions:
  `checkout@v4`, `setup-qemu@v3`, `setup-buildx@v3`, `login-action@v3`,
  `build-push-action@v6`, `stale@v9`
- `.github/workflows/test.yml` — restructured as a 3-stage dependent pipeline:
  `lint` → `build-test` → `publish`
- `dockerfiles/Dockerfile-test` — now uses selective `COPY` layers, parallel build
  with `nproc` fallback, and explicit `ctest --output-on-failure` instead of `make test`
- `doc/BuildingPeridigm.md` — updated to C++17, CMake ≥ 3.8, Docker quick-start,
  requirements table, optional flags, `ctest` usage
- `doc/InstallingThirdPartyLibs.md` — expanded with dependency table, Docker path,
  yaml-cpp Trilinos TPL requirement
- `doc/RunningSimulationsDocker.md` — updated to `docker compose` v2 syntax,
  added image architecture diagram, Windows note
- `.gitignore` — added `logs/`, `build/`, CMake artefacts, Python cache,
  IDE metadata, OS junk

### Fixed
- `CMakeLists.txt` — typo `Cmake_minimum_required` → `cmake_minimum_required`
  (silently accepted on case-insensitive file systems, breaks on strict Linux)

### Security
- Docker Hub credentials no longer used on external PR builds (push gate)
- `OMPI_ALLOW_RUN_AS_ROOT` scoped to explicit test containers only

---

## [1.x.x] — Pre-2026 Releases

> Historical release notes have not been migrated to this format.  
> See [git log](https://github.com/cloud9legendre/peridigm/commits/master) for the
> full commit history.
