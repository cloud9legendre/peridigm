# CMake generated Testfile for 
# Source directory: /home/ashen/Documents/peridigm/src/compute/unit_test
# Build directory: /home/ashen/Documents/peridigm/build/src/compute/unit_test
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(utPeridigm_Compute_Force "python" "/home/ashen/Documents/peridigm/build/scripts/run_unit_test.py" "./utPeridigm_Compute_Force")
set_tests_properties(utPeridigm_Compute_Force PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/compute/unit_test/CMakeLists.txt;49;add_test;/home/ashen/Documents/peridigm/src/compute/unit_test/CMakeLists.txt;0;")
add_test(utPeridigm_Compute_Force_MPI_np2 "python" "/home/ashen/Documents/peridigm/build/scripts/run_unit_test.py" "mpiexec" "-np" "2" "./utPeridigm_Compute_Force")
set_tests_properties(utPeridigm_Compute_Force_MPI_np2 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/compute/unit_test/CMakeLists.txt;50;add_test;/home/ashen/Documents/peridigm/src/compute/unit_test/CMakeLists.txt;0;")
add_test(utPeridigm_Compute_Angular_Momentum "python" "/home/ashen/Documents/peridigm/build/scripts/run_unit_test.py" "./utPeridigm_Compute_Angular_Momentum")
set_tests_properties(utPeridigm_Compute_Angular_Momentum PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/compute/unit_test/CMakeLists.txt;52;add_test;/home/ashen/Documents/peridigm/src/compute/unit_test/CMakeLists.txt;0;")
add_test(utPeridigm_Compute_Angular_Momentum_MPI_np2 "python" "/home/ashen/Documents/peridigm/build/scripts/run_unit_test.py" "mpiexec" "-np" "2" "./utPeridigm_Compute_Angular_Momentum")
set_tests_properties(utPeridigm_Compute_Angular_Momentum_MPI_np2 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/compute/unit_test/CMakeLists.txt;53;add_test;/home/ashen/Documents/peridigm/src/compute/unit_test/CMakeLists.txt;0;")
add_test(utPeridigm_Compute_Linear_Momentum "python" "/home/ashen/Documents/peridigm/build/scripts/run_unit_test.py" "./utPeridigm_Compute_Linear_Momentum")
set_tests_properties(utPeridigm_Compute_Linear_Momentum PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/compute/unit_test/CMakeLists.txt;55;add_test;/home/ashen/Documents/peridigm/src/compute/unit_test/CMakeLists.txt;0;")
add_test(utPeridigm_Compute_Linear_Momentum_MPI_np2 "python" "/home/ashen/Documents/peridigm/build/scripts/run_unit_test.py" "mpiexec" "-np" "2" "./utPeridigm_Compute_Linear_Momentum")
set_tests_properties(utPeridigm_Compute_Linear_Momentum_MPI_np2 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/compute/unit_test/CMakeLists.txt;56;add_test;/home/ashen/Documents/peridigm/src/compute/unit_test/CMakeLists.txt;0;")
add_test(utPeridigm_Compute_Kinetic_Energy "python" "/home/ashen/Documents/peridigm/build/scripts/run_unit_test.py" "./utPeridigm_Compute_Kinetic_Energy")
set_tests_properties(utPeridigm_Compute_Kinetic_Energy PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/compute/unit_test/CMakeLists.txt;61;add_test;/home/ashen/Documents/peridigm/src/compute/unit_test/CMakeLists.txt;0;")
add_test(utPeridigm_Compute_Kinetic_Energy_MPI_np2 "python" "/home/ashen/Documents/peridigm/build/scripts/run_unit_test.py" "mpiexec" "-np" "2" "./utPeridigm_Compute_Kinetic_Energy")
set_tests_properties(utPeridigm_Compute_Kinetic_Energy_MPI_np2 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/compute/unit_test/CMakeLists.txt;62;add_test;/home/ashen/Documents/peridigm/src/compute/unit_test/CMakeLists.txt;0;")
