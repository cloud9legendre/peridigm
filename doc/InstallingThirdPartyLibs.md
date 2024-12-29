# Installing Third-Party Packages and Libraries

## Necessary Libraries
1. Save the following script as `install_packages.sh`.
2. In the script directory, execute `chmod +x install_packages.sh`.
3. Run the script with `./install_packages.sh`.

```bash
#!/bin/bash

# Update the package list and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install GNU Fortran, C, and C++ compilers
sudo apt install -y gfortran gcc g++

# Install CMake
sudo apt install -y cmake

# Install OpenMPI
sudo apt install -y openmpi-bin libopenmpi-dev

# Install Python and necessary development packages
sudo apt install -y python3 python3-dev python3-pip

# Install libbz2 development package
sudo apt install -y libbz2-dev

# Install zlib development package
sudo apt install -y zlib1g-dev

# Install m4 macro processor
sudo apt install -y m4

# Install BLAS and LAPACK libraries
sudo apt install -y libblas-dev liblapack-dev

# Install libX11 development package
sudo apt install -y libx11-dev

# Clean up
sudo apt autoremove -y

# Confirm installation
printf "\nInstallation complete. The following packages have been installed:\n"
echo "- GNU Fortran, C, and C++ compilers"
echo "- CMake"
echo "- OpenMPI"
echo "- Python (with development headers and pip)"
echo "- libbz2-dev"
echo "- zlib1g-dev"
echo "- m4"
echo "- BLAS and LAPACK libraries"
echo "- libX11-dev"
```

## Boost
1. Download and extract Boost.
2. Create `install_boost.sh` inside the source directory.

```bash
# Set environment variables for MPI compilers
export CC=mpicc
export CXX=mpicxx
export FC=mpif90
export F77=mpif77

# Run the Boost bootstrap script
./bootstrap.sh

# Add "using mpi" to project-config.jam
echo "using mpi ;" >> project-config.jam

# Compile and install Boost using the Boost's bjam build system
./b2 install --prefix=/usr/local/boost/
```

3. Add Boost to the PATH.

```bash
export PATH="/usr/local/boost/include:$PATH"
export LD_LIBRARY_PATH="/usr/local/boost/lib:$LD_LIBRARY_PATH"
```

## HDF5
1. Download the HDF5 `tar.gz` file.
2. Extract it with `tar -xvf hdf5.tar`.
3. Navigate to the directory: `cd hdf5`.
4. Save the following script as `install_hdf5.sh`.

```bash
# Set environment variables for MPI compilers
export CC=mpicc
export CXX=mpicxx
export FC=mpif90
export F77=mpif77

# Configure HDF5
./configure --enable-parallel --prefix=/usr/local/bin/hdf5/

# Make and install HDF5
make -j 4
make install
```

5. Make the script executable: `chmod +x install_hdf5.sh`.
6. Run the script: `sudo ./install_hdf5.sh`.
7. Add HDF5 to the PATH in `~/.bashrc`.

```bash
export PATH="$PATH:/usr/local/bin/hdf5/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/bin/hdf5/lib"
```

## NetCDF
1. Download and install PNetCDF.
2. Download the NetCDF source file.
3. Navigate to the source directory: `cd NetCdfS`.
4. Save the following script as `install_netcdf.sh`.

```bash
# Set environment variables for MPI compilers
export CC=mpicc
export CXX=mpicxx
export FC=mpif90
export F77=mpif77

# Configure NetCDF
CPPFLAGS="-I/usr/local/include -I/usr/local/bin/hdf5/include" LDFLAGS="-L/usr/local/lib -L/usr/local/bin/hdf5/lib" ./configure --prefix=/usr/local/netcdf/ --enable-netcdf-4 --disable-v2 --disable-fsync --disable-dap --disable-shared --enable-parallel-tests --enable-pnetcdf 

# Make, test, and install NetCDF
make -j 4
make check
make install
```

5. Make the script executable: `chmod +x install_netcdf.sh`.
6. Run the script: `sudo ./install_netcdf.sh`.
7. Add NetCDF to the PATH in `~/.bashrc`.

```bash
export PATH="/usr/local/netcdf/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/netcdf/lib:$LD_LIBRARY_PATH"
export C_INCLUDE_PATH="/usr/local/netcdf/include:$C_INCLUDE_PATH"
```

## Trilinos (Version 16)
1. Download the Trilinos source code and create a build directory.
2. Navigate to the build directory: `cd Trilinos/build`.
3. Save the following script as `install_trilinos.sh`.

```bash
rm -f CMakeCache.txt
rm -rf CMakeFiles/

cmake -D CMAKE_INSTALL_PREFIX:PATH=/usr/local/bin/trilinos/ \
-D MPI_BASE_DIR:PATH="/usr/lib/x86_64-linux-gnu/openmpi" \
-D CMAKE_CXX_FLAGS:STRING="-O2 -std=c++11 -pedantic -ftrapv -Wall -Wno-long-long" \
-D CMAKE_BUILD_TYPE:STRING=RELEASE \
-D Trilinos_WARNINGS_AS_ERRORS_FLAGS:STRING="" \
-D Trilinos_ENABLE_ALL_PACKAGES:BOOL=OFF \
-D Trilinos_ENABLE_Teuchos:BOOL=ON \
-D Trilinos_ENABLE_Shards:BOOL=ON \
-D Trilinos_ENABLE_Sacado:BOOL=ON \
-D Trilinos_ENABLE_Epetra:BOOL=ON \
-D Trilinos_ENABLE_EpetraExt:BOOL=ON \
-D Trilinos_ENABLE_Ifpack:BOOL=ON \
-D Trilinos_ENABLE_AztecOO:BOOL=ON \
-D Trilinos_ENABLE_Amesos:BOOL=ON \
-D Trilinos_ENABLE_Anasazi:BOOL=ON \
-D Trilinos_ENABLE_Belos:BOOL=ON \
-D Trilinos_ENABLE_ML:BOOL=ON \
-D Trilinos_ENABLE_Phalanx:BOOL=ON \
-D Trilinos_ENABLE_Intrepid:BOOL=ON \
-D Trilinos_ENABLE_NOX:BOOL=ON \
-D Trilinos_ENABLE_Stratimikos:BOOL=ON \
-D Trilinos_ENABLE_Thyra:BOOL=ON \
-D Trilinos_ENABLE_Rythmos:BOOL=ON \
-D Trilinos_ENABLE_MOOCHO:BOOL=ON \
-D Trilinos_ENABLE_TriKota:BOOL=OFF \
-D Trilinos_ENABLE_Stokhos:BOOL=ON \
-D Trilinos_ENABLE_Zoltan:BOOL=ON \
-D Trilinos_ENABLE_Piro:BOOL=ON \
-D Trilinos_ENABLE_Teko:BOOL=ON \
-D Trilinos_ENABLE_SEACASIoss:BOOL=ON \
-D Trilinos_ENABLE_SEACAS:BOOL=ON \
-D Trilinos_ENABLE_SEACASBlot:BOOL=ON \
-D Trilinos_ENABLE_Pamgen:BOOL=ON \
-D Trilinos_ENABLE_EXAMPLES:BOOL=OFF \
-D Trilinos_ENABLE_TESTS:BOOL=ON \
-D TPL_ENABLE_Matio:BOOL=OFF \
-D Trilinos_ENABLE_ThyraEpetraAdapters:BOOL=ON \
-D Trilinos_ENABLE_ThyraEpetraExtAdapters:BOOL=ON \
-D TPL_ENABLE_HDF5:BOOL=ON \
-D HDF5_INCLUDE_DIRS:PATH="/usr/local/bin/hdf5/include" \
-D HDF5_LIBRARY_DIRS:PATH="/usr/local/bin/hdf5/lib" \
-D TPL_ENABLE_Netcdf:BOOL=ON \
-D Netcdf_INCLUDE_DIRS:PATH="/usr/local/netcdf/include" \
-D Netcdf_LIBRARY_DIRS:PATH="/usr/local/netcdf/lib" \
-D TPL_ENABLE_MPI:BOOL=ON \
-D TPL_ENABLE_BLAS:BOOL=ON \
-D TPL_ENABLE_LAPACK:BOOL=ON \
-D TPL_ENABLE_Boost:BOOL=ON \
-D Boost_INCLUDE_DIRS:PATH="/usr/local/boost/include" \
-D Boost_LIBRARY_DIRS:PATH="/usr/local/boost/lib" \
-D CMAKE_VERBOSE_MAKEFILE:BOOL=OFF \
-D Trilinos_VERBOSE_CONFIGURE:BOOL=OFF \
<Path to Trilinos Source>
```

4. Make the script executable: `chmod +x install_trilinos.sh`.
5. Run the script: `sudo ./install_trilinos.sh`.
6. Build Trilinos with `make -j 4`.
7. Install Trilinos with `make install`. 
