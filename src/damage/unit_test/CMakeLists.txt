#
# Unit tests for the src/damage module
#
# Test targets registered here follow the same pattern as src/compute/unit_test.
# Each executable is linked against Peridigm_LIBRARY and Trilinos_LIBRARIES.
#
# To build only these tests from your CMake build directory:
#   cmake --build . --target utPeridigm_CriticalStretchDamageModel
#
# To run only these tests:
#   ctest --output-on-failure -R "utPeridigm_Damage"
#

set(utPeridigm_CriticalStretchDamageModel_SOURCES
    ./unitTestMain.cpp
    ./utPeridigm_CriticalStretchDamageModel.cpp
)

add_executable(utPeridigm_CriticalStretchDamageModel
    ${utPeridigm_CriticalStretchDamageModel_SOURCES}
)
target_link_libraries(utPeridigm_CriticalStretchDamageModel
    ${Peridigm_LIBRARY}
    ${Peridigm_LINK_LIBRARIES}
)

# Register tests for single-rank and 2-rank MPI runs
add_test(utPeridigm_CriticalStretchDamageModel
    python ${CMAKE_BINARY_DIR}/scripts/run_unit_test.py
    ./utPeridigm_CriticalStretchDamageModel
)
add_test(utPeridigm_CriticalStretchDamageModel_MPI_np2
    python ${CMAKE_BINARY_DIR}/scripts/run_unit_test.py
    mpiexec -np 2 ./utPeridigm_CriticalStretchDamageModel
)
