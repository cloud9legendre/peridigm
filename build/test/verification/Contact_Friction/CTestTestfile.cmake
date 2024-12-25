# CMake generated Testfile for 
# Source directory: /home/ashen/Documents/peridigm/test/verification/Contact_Friction
# Build directory: /home/ashen/Documents/peridigm/build/test/verification/Contact_Friction
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(Contact_Friction_np1 "python" "./np1/Contact_Friction.py")
set_tests_properties(Contact_Friction_np1 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/test/verification/Contact_Friction/CMakeLists.txt;1;add_test;/home/ashen/Documents/peridigm/test/verification/Contact_Friction/CMakeLists.txt;0;")
add_test(Contact_Friction_np2 "python" "./np2/Contact_Friction.py")
set_tests_properties(Contact_Friction_np2 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/test/verification/Contact_Friction/CMakeLists.txt;2;add_test;/home/ashen/Documents/peridigm/test/verification/Contact_Friction/CMakeLists.txt;0;")
