rm -f CMakeCache.txt
rm -rf CMakeFiles/

cmake \
-D CMAKE_BUILD_TYPE:STRING=Release \
-D Trilinos_DIR:PATH=/usr/local/bin/trilinos/lib/cmake/Trilinos \
-D CMAKE_C_COMPILER:STRING=/usr/bin/mpicc \
-D CMAKE_CXX_COMPILER:STRING=/usr/bin/mpicxx \
-D BOOST_ROOT=/usr/local/boost \
-D CMAKE_CXX_FLAGS:STRING="-O2 -Wall -std=c++11 -pedantic -Wno-long-long -ftrapv -Wno-deprecated" \
/home/ashen/Documents/peridigm

