# Peridigm Development / Build Image
#
# This is the ROOT Dockerfile, used for local development and as a development
# reference.  The CI pipeline uses dockerfiles/Dockerfile-test (build+test)
# and dockerfiles/Dockerfile-master (minimal production image).
#
# Docker Image Hierarchy:
#   peridigm/trilinos:<version>   -- pre-built Trilinos base (not built here)
#         │
#         └─ peridigm/peridigm:test   -- built by dockerfiles/Dockerfile-test
#                   │
#                   └─ peridigm/peridigm:latest  -- built by dockerfiles/Dockerfile-master
#
# Usage:
#   docker build -t peridigm-dev .
#   docker run -it --rm peridigm-dev /bin/bash
#   docker run --rm peridigm-dev ctest --output-on-failure

# Pin to a specific Trilinos image version for reproducible builds.
# Update this SHA when intentionally upgrading the Trilinos base.
# To find the current digest: docker inspect peridigm/trilinos:latest --format='{{index .RepoDigests 0}}'
FROM peridigm/trilinos:latest
# TODO: pin to digest once a stable Trilinos release tag is established, e.g.:
# FROM peridigm/trilinos@sha256:<digest>

LABEL maintainer="Peridigm Developers <https://github.com/peridigm/peridigm>"
LABEL description="Peridigm development build image — source compiled against Trilinos"
LABEL org.opencontainers.image.source="https://github.com/peridigm/peridigm"

# Non-interactive APT installs
ENV DEBIAN_FRONTEND=noninteractive \
    HOME=/root

# Allow OpenMPI to run as root inside the container.
# This is standard practice for HPC containers and is safe here because the
# container is ephemeral and isolated.  Do NOT set this in images used as
# bases for services or long-running workloads.
ENV OMPI_ALLOW_RUN_AS_ROOT=1 \
    OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1

# Ensure 'python' resolves to python3 (required by CMake helper scripts)
RUN ln -sf /usr/bin/python3 /usr/bin/python || true

# Copy source (COPY order maximises layer cache reuse on iterative builds)
WORKDIR /peridigm
COPY CMakeLists.txt .
COPY src/     src/
COPY test/    test/
COPY scripts/ scripts/
COPY examples/ examples/
COPY dockerfiles/ dockerfiles/

# Repair Windows-checkout symlink stubs and CRLF endings in the test tree.
# See scripts/fix_test_infrastructure.sh for details.
RUN chmod +x /peridigm/scripts/fix_test_infrastructure.sh && \
    /peridigm/scripts/fix_test_infrastructure.sh /peridigm/test

# Configure and compile Peridigm
RUN mkdir -p /peridigm/build
WORKDIR /peridigm/build

RUN cmake \
    -D CMAKE_BUILD_TYPE:STRING=Release \
    -D TRILINOS_DIR:PATH=/usr/local/trilinos \
    -D CMAKE_CXX_COMPILER:STRING="mpicxx" \
    -D CMAKE_C_COMPILER:STRING="mpicc" \
    -D CMAKE_INSTALL_PREFIX:PATH=/usr/local/peridigm \
    -D ALBANY_SEACAS:BOOL=ON \
    ..

# Parallel build with safe fallback for environments where nproc is unavailable
RUN make -j"$(nproc || echo 4)"

# Default command: print usage information, then drop to a shell.
# Override with a specific command:
#   docker run --rm <image> ctest --output-on-failure
#   docker run --rm <image> Peridigm my_sim.yaml
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["echo 'Peridigm development image.'; \
     echo 'Usage:'; \
     echo '  Run all tests:  docker run --rm <image> ctest --output-on-failure'; \
     echo '  Run simulation: docker run --rm -v $PWD:/output <image> Peridigm sim.yaml'; \
     echo '  Interactive:    docker run -it --rm <image> /bin/bash'; \
     exec /bin/bash"]
