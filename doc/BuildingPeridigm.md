# Building Peridigm

Peridigm is a C++ code for massively parallel peridynamics simulations.  It uses the
[CMake](https://cmake.org/) build system and depends on [Trilinos](https://trilinos.github.io/)
and several third-party libraries.

> [!TIP]
> **Recommended for most users:** build and run inside Docker — skip directly to the
> [Docker Quick-Start](#docker-quick-start) section.  Native builds are required only
> when modifying source or running performance tests on bare metal.

---

## Requirements

| Requirement | Minimum Version | Notes |
|---|---|---|
| CMake | **3.8** | Required for native C++17 standard support |
| C++ compiler | GCC ≥ 7 or Intel ≥ 19 | Must be C++17-compliant |
| MPI | OpenMPI ≥ 3.0 or MPICH ≥ 3.0 | Use `mpicxx`/`mpicc` wrappers |
| Trilinos | 14.x recommended | Built with SEACAS, Epetra, Teuchos, NOX, Zoltan |
| yaml-cpp | Any modern release | Must be in Trilinos TPL list |
| BLAS / LAPACK | System package | `libblas-dev liblapack-dev` on Debian/Ubuntu |
| Python | 3.6+ | Required for CMake helper scripts |

---

## Docker Quick-Start

The fastest way to build and test Peridigm is using the pre-built Docker images.
No Trilinos or third-party library installation is required.

```bash
# Pull and run tests (recommended for CI and first-time users)
docker pull peridigm/peridigm:test
docker run --rm peridigm/peridigm:test ctest --output-on-failure

# Start an interactive development shell
docker run -it --rm -v "$PWD":/workspace peridigm/peridigm:test /bin/bash
```

For running simulations, see [RunningSimulationsDocker.md](RunningSimulationsDocker.md).

---

## Native Build (Linux / macOS)

### 1 — Install Third-Party Libraries

Follow [InstallingThirdPartyLibs.md](InstallingThirdPartyLibs.md) to install
Trilinos (with SEACAS), HDF5, NetCDF, Boost, and yaml-cpp.

### 2 — Create an Out-of-Source Build Directory

Always build outside the source tree to keep it clean:

```bash
mkdir -p /path/to/peridigm-build
cd /path/to/peridigm-build
```

### 3 — Configure with CMake

```bash
cmake \
  -D CMAKE_BUILD_TYPE:STRING=Release \
  -D CMAKE_C_COMPILER:STRING=mpicc \
  -D CMAKE_CXX_COMPILER:STRING=mpicxx \
  -D TRILINOS_DIR:PATH=/usr/local/trilinos \
  -D ALBANY_SEACAS:BOOL=ON \
  /path/to/peridigm/source
```

**Optional flags:**

| Flag | Default | Description |
|---|---|---|
| `-D USE_PV=ON` | OFF | Enable partial-volume calculations |
| `-D USE_LCM=ON` | OFF | Enable LCM material models (requires Albany) |
| `-D ENABLE_INSTALL=ON` | OFF | Generate install targets |
| `-D PERFORMANCE_TEST_MACHINE=<name>` | — | Enable performance test suite |

### 4 — Compile

```bash
# Use all available cores; falls back to 4 if nproc is unavailable
make -j"$(nproc || echo 4)"
```

### 5 — Run the Test Suite

```bash
# Preferred: verbose output on failure, with per-test timeout
ctest --output-on-failure --timeout 300

# Run only unit tests (fast, no SEACAS tools required)
ctest --output-on-failure -R "^utPeridigm"

# Run only verification tests
ctest --output-on-failure -R "^Peridigm_"
```

> [!NOTE]
> Most regression and verification tests require the SEACAS tools (`exodiff`, `epu`).
> If Trilinos was built without SEACAS these tests will be skipped.
> Use `-DALBANY_SEACAS=ON` at configure time to enable them.

### Repair Windows-Checkout Artifacts (after `git clone` on Windows)

If you cloned on Windows and are building on Linux, run:

```bash
cmake --build . --target fix-test-infra
```

This restores symlink stubs in `test/` to real symlinks and strips Windows
CRLF endings from exodiff comparison files.

---

## Windows Native Builds

Peridigm is primarily developed for Linux.  Windows builds are experimental and
require WSL2 (Windows Subsystem for Linux) or the Docker workflow described above.

If building under WSL2, follow the native Linux instructions inside the WSL terminal.

---

## Verifying Your Build

After `make` completes, the `Peridigm` executable will be in your build directory.
Verify it launches correctly:

```bash
./Peridigm --help
```
