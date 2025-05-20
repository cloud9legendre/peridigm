# NetCDF

[NetCDF](https://github.com/Unidata/netcdf-c/releases) is required by the Trilinos SEACAS package. 
Prior to compiling NetCDF, it is recommended that you modify the file netcdf.h to better support 
large-scale Peridigm simulations, as described below.

An example build process for [NetCDF](https://github.com/Unidata/netcdf-c/releases):


````
# Set environment variables for MPI compilers
export CC=mpicc
export CXX=mpicxx
export FC=mpif90
export F77=mpif77
````

Modify the following `#define` statements in the `netcdf.h` file.  Change the values to match what is given below.

````
#define NC_MAX_DIMS 65536                                                                                                    
#define NC_MAX_ATTRS 8192                                                                                      
#define NC_MAX_VARS 524288                                                                                                    
#define NC_MAX_NAME 256                                                                                                      
#define NC_MAX_VAR_DIMS 8   
````

Alternatively, you can install [this fork](https://github.com/johntfoster/netcdf-c) of NetCDF where the changes have already
been made.  This version is known to work with Trilinos and Peridigm.

````
# Configure NetCDF
./configure --prefix=/usr/local/netcdf --enable-parallel--enable-netcdf-4 --disable-v2 --disable-fsync --disable-dap
````

````
# Make, test, and install NetCDF
make -j 8
make check
make install
````
Install pnetcdf 1.14.0
```
# pnetcdf_config.sh

# 1A) Export OpenMPI wrappers
export MPICC=/usr/lib/x86_64-linux-gnu/openmpi/bin/mpicc      # OpenMPI C compiler
export MPICXX=/usr/lib/x86_64-linux-gnu/openmpi/bin/mpicxx  # OpenMPI C++ compiler
export MPIFC=/usr/lib/x86_64-linux-gnu/openmpi/bin/mpif90   # OpenMPI Fortran compiler

# 1B) Enable PIC so objects can link into shared libs
export CFLAGS="-O3 -fPIC"
export CXXFLAGS="-O3 -fPIC"
export FFLAGS="-O3 -fPIC"

# 1C) Configure + build
./configure \
  --prefix=$HOME/ashen/pnetcdf \
  --enable-shared \
  --enable-static
make -j8
make install

# Verify
ls $HOME/ashen/pnetcdf/lib/libpnetcdf.* 

```
Install netcdf 4.9.2
```
netcdf_config.sh
# Set environment variables for MPI compilers
export CC=mpicc
export CXX=mpicxx
export FC=mpif90
export F77=mpif77

# Export flags for HDF5 and PnetCDF
export CPPFLAGS="-I/home/yashoo/ashen/hdf5/include -I/home/yashoo/ashen/pnetcdf/include"
export LDFLAGS="-L/home/yashoo/ashen/hdf5/lib -L/home/yashoo/ashen/pnetcdf/lib"
                
export CFLAGS="-O3 -fPIC"
export CXXFLAGS="-O3 -fPIC"
export FFLAGS="-O3 -fPIC"

# Reconfigure with PnetCDF support and parallel tests enabled
./configure --prefix=/home/yashoo/ashen/netcdf/ --enable-parallel --enable-pnetcdf --enable-netcdf-4 --disable-v2 --disable-fsync --disable-dap CPPFLAGS="$CPPFLAGS" LDFLAGS="$LDFLAGS"


make -j 8
make check

```
