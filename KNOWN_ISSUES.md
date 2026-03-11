# Known Issues

This document tracks verified test failures and infrastructure issues that have been
identified but are not yet fully resolved.  Each entry includes the affected test,
error details, probable cause, and current status.

---

## Test Failures

### `MultipleHorizons` — NP=1 runtime error

| Field | Details |
|---|---|
| **Test** | `test/verification/MultipleHorizons` (1 MPI rank) |
| **Log** | `logs/MultipleHorizons_np1_err.log` |
| **Symptom** | Process exits with non-zero status on single-rank run |
| **Probable cause** | Horizon manager may assume a minimum neighbour count that is not satisfied at the global domain boundary when running with NP=1 |
| **Status** | Under investigation — NP>1 run passes |
| **Work-around** | Run with `-np 2` or more |

---

### `MultipleOutputFiles` — exodiff mismatch (NP=2)

| Field | Details |
|---|---|
| **Test** | `test/regression/MultipleOutputFiles` (2 MPI ranks) |
| **Log** | `logs/exodiff_multiple_np2_2.log` |
| **Symptom** | `exodiff` reports field-value mismatches in the second output file |
| **Probable cause** | Likely an output file ordering or EPU gather race condition when multiple output files are generated concurrently |
| **Status** | Logged; root-cause analysis in progress |
| **Work-around** | None at this time |

---

## Infrastructure Notes

### Windows checkout — symlink stubs

Git on Windows with `core.symlinks=false` converts symlinks in `test/` to small
plain-text stub files.  This breaks the test tree on Linux/Docker.

**Resolution:**
- **Docker / Linux CI:** `scripts/fix_test_infrastructure.sh` is run automatically
  during the Docker image build (see `Dockerfile` and `dockerfiles/Dockerfile-test`).
- **Native Linux (after Windows checkout):** run
  `cmake --build . --target fix-test-infra`
- **Native Windows:** run `.\scripts\fix_test_infrastructure.ps1` (requires
  Administrator or Developer Mode for symbolic-link creation).

### SEACAS tools not in PATH

Most regression and verification tests depend on `exodiff` and `epu` from the
Trilinos SEACAS library.  If CMake is configured without `-DALBANY_SEACAS=ON`,
or Trilinos was built without SEACAS, these tests will be configured but will
fail silently at runtime.

**Resolution:** Rebuild Trilinos with SEACAS enabled, or use the pre-built
Docker image `peridigm/peridigm:test`.
