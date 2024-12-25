# CMake generated Testfile for 
# Source directory: /home/ashen/Documents/peridigm/src/materials/unit_test
# Build directory: /home/ashen/Documents/peridigm/build/src/materials/unit_test
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(utPeridigm_ElasticMaterial "python" "/home/ashen/Documents/peridigm/build/scripts/run_unit_test.py" "./utPeridigm_ElasticMaterial")
set_tests_properties(utPeridigm_ElasticMaterial PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/materials/unit_test/CMakeLists.txt;24;add_test;/home/ashen/Documents/peridigm/src/materials/unit_test/CMakeLists.txt;0;")
add_test(utPeridigm_MultiphysicsElasticMaterial "python" "/home/ashen/Documents/peridigm/build/scripts/run_unit_test.py" "./utPeridigm_MultiphysicsElasticMaterial")
set_tests_properties(utPeridigm_MultiphysicsElasticMaterial PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/src/materials/unit_test/CMakeLists.txt;36;add_test;/home/ashen/Documents/peridigm/src/materials/unit_test/CMakeLists.txt;0;")
subdirs("twoPoint_SLS_Relaxation")
subdirs("utPeridigm_ElasticPlastic")
