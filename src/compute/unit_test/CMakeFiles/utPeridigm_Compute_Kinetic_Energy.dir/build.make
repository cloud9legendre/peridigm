# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.28

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ashen/Documents/peridigm

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ashen/Documents/peridigm

# Include any dependencies generated for this target.
include src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/compiler_depend.make

# Include the progress variables for this target.
include src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/progress.make

# Include the compile flags for this target's objects.
include src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/flags.make

src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/utPeridigm_Compute_Kinetic_Energy.cpp.o: src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/flags.make
src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/utPeridigm_Compute_Kinetic_Energy.cpp.o: src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy.cpp
src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/utPeridigm_Compute_Kinetic_Energy.cpp.o: src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/ashen/Documents/peridigm/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/utPeridigm_Compute_Kinetic_Energy.cpp.o"
	cd /home/ashen/Documents/peridigm/src/compute/unit_test && /usr/bin/mpicxx $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/utPeridigm_Compute_Kinetic_Energy.cpp.o -MF CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/utPeridigm_Compute_Kinetic_Energy.cpp.o.d -o CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/utPeridigm_Compute_Kinetic_Energy.cpp.o -c /home/ashen/Documents/peridigm/src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy.cpp

src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/utPeridigm_Compute_Kinetic_Energy.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/utPeridigm_Compute_Kinetic_Energy.cpp.i"
	cd /home/ashen/Documents/peridigm/src/compute/unit_test && /usr/bin/mpicxx $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ashen/Documents/peridigm/src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy.cpp > CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/utPeridigm_Compute_Kinetic_Energy.cpp.i

src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/utPeridigm_Compute_Kinetic_Energy.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/utPeridigm_Compute_Kinetic_Energy.cpp.s"
	cd /home/ashen/Documents/peridigm/src/compute/unit_test && /usr/bin/mpicxx $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ashen/Documents/peridigm/src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy.cpp -o CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/utPeridigm_Compute_Kinetic_Energy.cpp.s

# Object files for target utPeridigm_Compute_Kinetic_Energy
utPeridigm_Compute_Kinetic_Energy_OBJECTS = \
"CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/utPeridigm_Compute_Kinetic_Energy.cpp.o"

# External object files for target utPeridigm_Compute_Kinetic_Energy
utPeridigm_Compute_Kinetic_Energy_EXTERNAL_OBJECTS =

src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/utPeridigm_Compute_Kinetic_Energy.cpp.o
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/build.make
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: src/libPeridigmLib.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: src/libPeridigmLib.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: src/io/pdneigh/libPdNeigh.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: src/io/mesh_input/quick_grid/libQuickGrid.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: src/io/utilities/libUtilities.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: src/materials/libPdMaterialUtilities.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libpiro.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/librol.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos_muelu.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos_muelu_pce_serial.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos_muelu_mp_16_serial.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos_ifpack2.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos_ifpack2_pce_serial.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos_ifpack2_mp_16_serial.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos_amesos2.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos_xpetra.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos_xpetra_pce_serial.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos_xpetra_mp_16_serial.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos_tpetra.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos_tpetraext_pce_serial.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos_tpetra_pce_serial.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos_tpetra_sd_pce_serial.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos_tpetraext_mp_16_serial.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos_tpetra_mp_16_serial.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos_tpetra_sd_mp_16_serial.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos_sacado.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstokhos.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libtempus.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libmuelu-adapters.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libmuelu.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/liblocatpetra.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/liblocathyra.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/liblocaepetra.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/liblocalapack.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libloca.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libnoxepetra.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libnoxlapack.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libnox.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libphalanx.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libintrepid2.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libintrepid.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libteko.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstratimikos.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstratimikosbelos.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstratimikosamesos2.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstratimikosaztecoo.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstratimikosamesos.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstratimikosml.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libstratimikosifpack.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libifpack2-adapters.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libifpack2.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libanasazitpetra.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libModeLaplace.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libanasaziepetra.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libanasazi.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libmapvarlib.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libblotlib.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libplt.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libsvdi_cgi.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libsvdi_cdr.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/lib/x86_64-linux-gnu/libX11.so
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libsuplib_cpp.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libsuplib_c.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libsuplib.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libsupes.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libaprepro_lib.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libchaco.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libio_info_lib.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libIonit.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libIotr.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libIohb.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libIogs.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libIotm.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libIogn.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libIovs.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libIonull.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libIopg.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libIoex.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libIoss.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/lib/x86_64-linux-gnu/libdl.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libnemesis.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libexoIIv2for32.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libexodus_for.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libexodus.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/netcdf-c-4.9.2/lib/libnetcdf.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/lib/libpnetcdf.so
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/lib/x86_64-linux-gnu/libcurl.so
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libamesos2.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libshylu_nodefastilu.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libtacho.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libbelosxpetra.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libbelostpetra.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libbelosepetra.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libbelos.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libml.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libifpack.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libzoltan2.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libpamgen_extras.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libpamgen.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libamesos.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libgaleri-xpetra.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libgaleri-epetra.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libaztecoo.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libxpetra.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libthyratpetra.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libthyraepetraext.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libthyraepetra.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libthyracore.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libtrilinosss.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libtpetraext.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libtpetrainout.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libtpetra.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libtpetraclassic.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libkokkostsqr.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libepetraext.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/hdf5-1.14.5/lib/libhdf5.so
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/lib/x86_64-linux-gnu/libz.so
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/hdf5-1.14.5/lib/libhdf5_hl.so
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libtriutils.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libshards.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libzoltan.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libepetra.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libminitensor.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libsacado.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/librtop.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libkokkoskernels.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libteuchoskokkoscomm.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libteuchoskokkoscompat.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libteuchosremainder.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libteuchosnumerics.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/lib/x86_64-linux-gnu/liblapack.so
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/lib/x86_64-linux-gnu/libblas.so
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libteuchoscomm.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libteuchosparameterlist.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libteuchosparser.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libteuchoscore.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libgtest.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libkokkoscontainers.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libkokkoscore.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: /usr/local/bin/trilinos/lib/libkokkossimd.a
src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy: src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/ashen/Documents/peridigm/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable utPeridigm_Compute_Kinetic_Energy"
	cd /home/ashen/Documents/peridigm/src/compute/unit_test && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/build: src/compute/unit_test/utPeridigm_Compute_Kinetic_Energy
.PHONY : src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/build

src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/clean:
	cd /home/ashen/Documents/peridigm/src/compute/unit_test && $(CMAKE_COMMAND) -P CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/cmake_clean.cmake
.PHONY : src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/clean

src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/depend:
	cd /home/ashen/Documents/peridigm && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ashen/Documents/peridigm /home/ashen/Documents/peridigm/src/compute/unit_test /home/ashen/Documents/peridigm /home/ashen/Documents/peridigm/src/compute/unit_test /home/ashen/Documents/peridigm/src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : src/compute/unit_test/CMakeFiles/utPeridigm_Compute_Kinetic_Energy.dir/depend

