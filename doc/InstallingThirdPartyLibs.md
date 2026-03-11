# Installing Third-Party Packages and Libraries

Peridigm depends on several third-party libraries.  The table below lists them all.

| Library | Role | Required |
|---|---|---|
| **Trilinos** | Core linear algebra, MPI, SEACAS mesh tools | ✅ Yes |
| **HDF5** | Binary data format used by NetCDF and ExodusII | ✅ Yes |
| **NetCDF** | Mesh I/O (ExodusII files read/written via NetCDF) | ✅ Yes |
| **Boost** | Used by Trilinos and utility code | ✅ Yes |
| **yaml-cpp** | YAML input-file parsing | ✅ Yes (must be a Trilinos TPL) |
| **BLAS / LAPACK** | Dense linear algebra kernels | ✅ Yes |
| **MPI** | Parallel communication (OpenMPI or MPICH) | ✅ Yes |
| **GSL** | GNU Scientific Library (quadrature) | Optional (`USE_IMPROVED_QUADRATURE`) |
| **Albany / LCM** | Additional material models | Optional (`USE_LCM`) |
| **Dakota** | UQ / optimization coupling | Optional (`USE_DAKOTA`, not yet wired) |

---

## Recommended: Docker (no manual installation)

If you only need to **run simulations or verify the build**, use the pre-built Docker
image — it ships with every dependency already compiled and installed:

```bash
# Pull the latest production image
docker pull peridigm/peridigm:latest

# Run a simulation
docker run --rm -v "$PWD":/output peridigm/peridigm:latest \
    Peridigm my_simulation.yaml

# Open an interactive shell
docker run -it --rm peridigm/peridigm:latest /bin/bash
```

The Trilinos base image (`peridigm/trilinos:latest`) used to build Peridigm is also
available if you want to compile Peridigm yourself inside Docker:

```bash
docker pull peridigm/trilinos:latest
```

---

## Manual Installation

For native builds, install the libraries in the order shown (dependencies first).

### System Packages (Debian / Ubuntu)

```bash
sudo apt-get update
sudo apt-get install -y \
    build-essential \
    cmake \
    python3 \
    gfortran \
    libopenmpi-dev openmpi-bin \
    libblas-dev liblapack-dev \
    libboost-dev \
    libyaml-cpp-dev \
    zlib1g-dev m4 curl wget
```

### Library Build Order & References

1. **[HDF5](HDF5.md)** — required before NetCDF
2. **[NetCDF](NetCDF.md)** — required before Trilinos with SEACAS
3. **[Boost](Boost.md)** — can be installed from system packages (see above)
4. **[Trilinos](Trilinos.md)** — must be built with SEACAS, Epetra, Teuchos, NOX, Zoltan, and **yaml-cpp as a TPL**

> [!IMPORTANT]
> **yaml-cpp must appear in the Trilinos TPL list** for Peridigm's YAML input parsing to work.
> Add `-D TPL_ENABLE_yaml-cpp=ON -D yaml-cpp_INCLUDE_DIRS=/usr/include -D yaml-cpp_LIBRARY_DIRS=/usr/lib` 
> (or equivalent paths) to your Trilinos CMake configuration.

> [!TIP]
> Build Trilinos with `-D Trilinos_ENABLE_SEACAS=ON` to enable the `exodiff`, `epu`, and
> `algebra` tools required for regression and verification testing.
