# CMake generated Testfile for 
# Source directory: /home/ashen/Documents/peridigm/test/verification/InterfaceAwareDamageModel
# Build directory: /home/ashen/Documents/peridigm/build/test/verification/InterfaceAwareDamageModel
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(InterfaceAwareDamageModelOneBlockNP1 "python" "./np1/InterfaceAwareDamageModelOneBlock.py")
set_tests_properties(InterfaceAwareDamageModelOneBlockNP1 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/test/verification/InterfaceAwareDamageModel/CMakeLists.txt;1;add_test;/home/ashen/Documents/peridigm/test/verification/InterfaceAwareDamageModel/CMakeLists.txt;0;")
add_test(InterfaceAwareDamageModelTwoBlocksSameValuesNP1 "python" "./np1/InterfaceAwareDamageModelTwoBlocksSameValues.py")
set_tests_properties(InterfaceAwareDamageModelTwoBlocksSameValuesNP1 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/test/verification/InterfaceAwareDamageModel/CMakeLists.txt;2;add_test;/home/ashen/Documents/peridigm/test/verification/InterfaceAwareDamageModel/CMakeLists.txt;0;")
add_test(InterfaceAwareDamageModelTwoBlocksDifferentValuesNP1 "python" "./np1/InterfaceAwareDamageModelTwoBlocksDifferentValues.py")
set_tests_properties(InterfaceAwareDamageModelTwoBlocksDifferentValuesNP1 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/test/verification/InterfaceAwareDamageModel/CMakeLists.txt;3;add_test;/home/ashen/Documents/peridigm/test/verification/InterfaceAwareDamageModel/CMakeLists.txt;0;")
add_test(InterfaceAwareDamageModelTwoBlocksDifferentValuesNP2 "python" "./np2/InterfaceAwareDamageModelTwoBlocksDifferentValues.py")
set_tests_properties(InterfaceAwareDamageModelTwoBlocksDifferentValuesNP2 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/test/verification/InterfaceAwareDamageModel/CMakeLists.txt;4;add_test;/home/ashen/Documents/peridigm/test/verification/InterfaceAwareDamageModel/CMakeLists.txt;0;")
add_test(InterfaceAwareDamageModelTwoBlocksDifferentValuesNP3 "python" "./np3/InterfaceAwareDamageModelTwoBlocksDifferentValues.py")
set_tests_properties(InterfaceAwareDamageModelTwoBlocksDifferentValuesNP3 PROPERTIES  _BACKTRACE_TRIPLES "/home/ashen/Documents/peridigm/test/verification/InterfaceAwareDamageModel/CMakeLists.txt;5;add_test;/home/ashen/Documents/peridigm/test/verification/InterfaceAwareDamageModel/CMakeLists.txt;0;")
