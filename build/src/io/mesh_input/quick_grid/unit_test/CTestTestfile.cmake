# CMake generated Testfile for 
# Source directory: /home/ashen/Documents/peridigm/src/io/mesh_input/quick_grid/unit_test
# Build directory: /home/ashen/Documents/peridigm/build/src/io/mesh_input/quick_grid/unit_test
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(ut_Q2CylinderRingHorizon "python" "/home/ashen/Documents/peridigm/build/scripts/run_unit_test.py" "./ut_Q2CylinderRingHorizon")
set_tests_properties(ut_Q2CylinderRingHorizon PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/io/mesh_input/quick_grid/unit_test/CMakeLists.txt;15;add_test;/home/ashen/Documents/peridigm/src/io/mesh_input/quick_grid/unit_test/CMakeLists.txt;0;")
add_test(ut_QuickGridHorizon "python" "/home/ashen/Documents/peridigm/build/scripts/run_unit_test.py" "./ut_QuickGridHorizon")
set_tests_properties(ut_QuickGridHorizon PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/io/mesh_input/quick_grid/unit_test/CMakeLists.txt;19;add_test;/home/ashen/Documents/peridigm/src/io/mesh_input/quick_grid/unit_test/CMakeLists.txt;0;")
add_test(ut_QuickGrid_solidCylinder_np1 "python" "/home/ashen/Documents/peridigm/build/scripts/run_unit_test.py" "./ut_QuickGrid_solidCylinder_np1")
set_tests_properties(ut_QuickGrid_solidCylinder_np1 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/io/mesh_input/quick_grid/unit_test/CMakeLists.txt;23;add_test;/home/ashen/Documents/peridigm/src/io/mesh_input/quick_grid/unit_test/CMakeLists.txt;0;")
add_test(ut_QuickGrid_solidCylinder_np2 "python" "/home/ashen/Documents/peridigm/build/scripts/run_unit_test.py" "mpiexec" "-np" "2" "./ut_QuickGrid_solidCylinder_np2")
set_tests_properties(ut_QuickGrid_solidCylinder_np2 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/io/mesh_input/quick_grid/unit_test/CMakeLists.txt;27;add_test;/home/ashen/Documents/peridigm/src/io/mesh_input/quick_grid/unit_test/CMakeLists.txt;0;")
add_test(ut_QuickGridMPI_np2_3x3x2 "python" "/home/ashen/Documents/peridigm/build/scripts/run_unit_test.py" "mpiexec" "-np" "2" "./ut_QuickGridMPI_np2_3x3x2")
set_tests_properties(ut_QuickGridMPI_np2_3x3x2 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/io/mesh_input/quick_grid/unit_test/CMakeLists.txt;31;add_test;/home/ashen/Documents/peridigm/src/io/mesh_input/quick_grid/unit_test/CMakeLists.txt;0;")
add_test(ut_QuickGridMPI_np3 "python" "/home/ashen/Documents/peridigm/build/scripts/run_unit_test.py" "mpiexec" "-np" "3" "--oversubscribe" "./ut_QuickGridMPI_np3")
set_tests_properties(ut_QuickGridMPI_np3 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/io/mesh_input/quick_grid/unit_test/CMakeLists.txt;35;add_test;/home/ashen/Documents/peridigm/src/io/mesh_input/quick_grid/unit_test/CMakeLists.txt;0;")
add_test(ut_SmallMeshCylinder_np4 "python" "/home/ashen/Documents/peridigm/build/scripts/run_unit_test.py" "mpiexec" "-np" "4" "--oversubscribe" "./ut_SmallMeshCylinder_np4")
set_tests_properties(ut_SmallMeshCylinder_np4 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/io/mesh_input/quick_grid/unit_test/CMakeLists.txt;39;add_test;/home/ashen/Documents/peridigm/src/io/mesh_input/quick_grid/unit_test/CMakeLists.txt;0;")
add_test(ut_SmallMeshCylinder "python" "/home/ashen/Documents/peridigm/build/scripts/run_unit_test.py" "./ut_SmallMeshCylinder")
set_tests_properties(ut_SmallMeshCylinder PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/io/mesh_input/quick_grid/unit_test/CMakeLists.txt;43;add_test;/home/ashen/Documents/peridigm/src/io/mesh_input/quick_grid/unit_test/CMakeLists.txt;0;")
