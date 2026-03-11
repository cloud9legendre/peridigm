# Running Simulations with Peridigm (Docker)

Peridigm ships as two Docker images:

| Image | Tag | Purpose |
|---|---|---|
| `peridigm/peridigm` | `:latest` | **Production** — run simulations |
| `peridigm/peridigm` | `:test` | CI build + test image |

The images are automatically rebuilt and pushed by CI on every merge to `master`.

---

## Single-Node Simulation (1 MPI rank)

Run from the directory containing your input file and mesh:

```bash
docker run --rm \
    -v "$PWD":/output \
    peridigm/peridigm:latest \
    Peridigm my_simulation.yaml
```

- `--rm` removes the container after it exits (keeps your system clean)
- `-v "$PWD":/output` mounts your current directory into the container as `/output`
- Output files (`.e`, `.exo`) are written back to your host directory

---

## Parallel Simulation (multiple MPI ranks, single host)

For multi-rank runs on a single machine, pass `mpiexec` directly:

```bash
docker run --rm \
    -v "$PWD":/output \
    peridigm/peridigm:latest \
    mpiexec -np 4 Peridigm my_simulation.yaml
```

Adjust `-np 4` to the number of cores you want to use.

---

## Parallel Simulation (multi-container with Docker Compose)

For production-scale parallel jobs use Docker Compose.
A `docker-compose.yml` is provided in the `dockerfiles/` directory and in some
example directories (e.g. `examples/fragmenting_cylinder`).

```bash
# Start a network of 4 Peridigm containers
docker compose up --scale peridigm=4 -d

# Execute the simulation across all containers
docker compose exec peridigm mpiexec -np 4 Peridigm my_simulation.yaml

# Tear down the network when done
docker compose down
```

> [!NOTE]
> `docker compose` (with a space, Docker Compose v2) is the current command.
> The older `docker-compose` (hyphen, v1) is deprecated and may not be installed
> on newer systems.

---

## Using a Specific Image Version

The `:latest` tag always points to the most recent successful build from `master`.
For reproducible results, pin to a specific commit SHA:

```bash
# List available tags on Docker Hub
docker pull peridigm/peridigm:<commit-sha>
```

Commit SHAs are tagged automatically by the CI pipeline.

---

## Windows / macOS Users

Docker Desktop is required on Windows and macOS.  The commands above work in:
- PowerShell or Command Prompt (Windows) — replace `$PWD` with `${PWD}` or `%CD%`
- Terminal.app / iTerm2 (macOS)

> [!IMPORTANT]
> If you cloned Peridigm on Windows before building inside Docker, symlinks in the
> `test/` directory may be corrupted (plain text stub files).  Run the repair script
> before mounting the source tree:
> ```powershell
> .\scripts\fix_test_infrastructure.ps1
> ```

---

## Image Architecture

```
peridigm/trilinos:latest   ← Pre-built Trilinos (HDF5, NetCDF, MPI, SEACAS, yaml-cpp)
         │
         └── peridigm/peridigm:test  ← Source compiled + CTest passes  [CI only]
                    │
                    └── peridigm/peridigm:latest  ← Minimal runtime image [production]
```
