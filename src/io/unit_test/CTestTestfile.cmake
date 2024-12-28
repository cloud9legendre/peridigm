# CMake generated Testfile for 
# Source directory: /home/ashen/Documents/peridigm/src/io/unit_test
# Build directory: /home/ashen/Documents/peridigm/src/io/unit_test
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(utPeridigm_ProximitySearch_np1 "python" "/home/ashen/Documents/peridigm/scripts/run_unit_test.py" "./utPeridigm_ProximitySearch")
set_tests_properties(utPeridigm_ProximitySearch_np1 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/io/unit_test/CMakeLists.txt;19;add_test;/home/ashen/Documents/peridigm/src/io/unit_test/CMakeLists.txt;0;")
add_test(utPeridigm_ProximitySearch_np2 "python" "/home/ashen/Documents/peridigm/scripts/run_unit_test.py" "mpiexec" "-np" "2" "./utPeridigm_ProximitySearch")
set_tests_properties(utPeridigm_ProximitySearch_np2 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/io/unit_test/CMakeLists.txt;20;add_test;/home/ashen/Documents/peridigm/src/io/unit_test/CMakeLists.txt;0;")
add_test(utPeridigm_ProximitySearch_np3 "python" "/home/ashen/Documents/peridigm/scripts/run_unit_test.py" "mpiexec" "-np" "3" "--oversubscribe" "./utPeridigm_ProximitySearch")
set_tests_properties(utPeridigm_ProximitySearch_np3 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/io/unit_test/CMakeLists.txt;21;add_test;/home/ashen/Documents/peridigm/src/io/unit_test/CMakeLists.txt;0;")
add_test(utPeridigm_ProximitySearch_np4 "python" "/home/ashen/Documents/peridigm/scripts/run_unit_test.py" "mpiexec" "-np" "4" "--oversubscribe" "./utPeridigm_ProximitySearch")
set_tests_properties(utPeridigm_ProximitySearch_np4 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/io/unit_test/CMakeLists.txt;22;add_test;/home/ashen/Documents/peridigm/src/io/unit_test/CMakeLists.txt;0;")
add_test(utPeridigm_SearchTree "python" "/home/ashen/Documents/peridigm/scripts/run_unit_test.py" "./utPeridigm_SearchTree")
set_tests_properties(utPeridigm_SearchTree PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/io/unit_test/CMakeLists.txt;30;add_test;/home/ashen/Documents/peridigm/src/io/unit_test/CMakeLists.txt;0;")
add_test(ut_kdtree_nn_search "python" "/home/ashen/Documents/peridigm/scripts/run_unit_test.py" "./ut_kdtree_nn_search")
set_tests_properties(ut_kdtree_nn_search PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/io/unit_test/CMakeLists.txt;46;add_test;/home/ashen/Documents/peridigm/src/io/unit_test/CMakeLists.txt;0;")
