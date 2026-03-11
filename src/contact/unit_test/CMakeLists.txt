#
# Unit tests for the src/contact module
#
# To build only these tests from your CMake build directory:
#   cmake --build . --target utPeridigm_ShortRangeForceContactModel
#
# To run only these tests:
#   ctest --output-on-failure -R "utPeridigm_Contact"
#

set(utPeridigm_ShortRangeForceContactModel_SOURCES
    ./unitTestMain.cpp
    ./utPeridigm_ShortRangeForceContactModel.cpp
)

add_executable(utPeridigm_ShortRangeForceContactModel
    ${utPeridigm_ShortRangeForceContactModel_SOURCES}
)
target_link_libraries(utPeridigm_ShortRangeForceContactModel
    ${Peridigm_LIBRARY}
    ${Peridigm_LINK_LIBRARIES}
)

add_test(utPeridigm_ShortRangeForceContactModel
    python ${CMAKE_BINARY_DIR}/scripts/run_unit_test.py
    ./utPeridigm_ShortRangeForceContactModel
)
add_test(utPeridigm_ShortRangeForceContactModel_MPI_np2
    python ${CMAKE_BINARY_DIR}/scripts/run_unit_test.py
    mpiexec -np 2 ./utPeridigm_ShortRangeForceContactModel
)
