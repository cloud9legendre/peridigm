# Install script for directory: /home/ashen/Documents/peridigm/test/verification

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/ashen/Documents/peridigm/test/verification/ShellBondFilter/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/ElasticBondBased/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/InitialDamage/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/LinearLPSBar/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/NeighborhoodVolume/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/ep_cube/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/ThermalExpansionCube/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/ThermalExpansionBondFailure/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/ThermalExpansionCubeElasticCorrespondence/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/Contact_Friction/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/Contact_Friction_Time_Dependent_Coefficient/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/Contact_2x1x1/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/BondBreakingInitialVelocity/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/BondBreakingInitialVelocity-EP/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/BondBreakingInitialVelocity_TimeDependentCS/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/AdaptiveQuasiStaticSolver/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/Compression_2x1x1/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/Compression_3x1x1/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/CompressionImplicit_2x1x1/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/CompressionImplicitEssentialBC_2x1x1/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/Compression_3x1x1_InfluenceFunction/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/CompressionInitDisp_2x1x1/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/VariableHorizonParsing/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/MultipleHorizons/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/ElasticCorrespondenceQSTension/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/IsotropicHardeningPlasticFullyPrescribedTension_NoFlaw/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/IsotropicHardeningPlasticFullyPrescribedTension_WithFlaw/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/ViscoplasticNeedlemanFullyPrescribedTension_WithFlaw/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/ViscoplasticNeedlemanFullyPrescribedTension_NoFlaw/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/ElasticPlasticCorrespondenceFullyPrescribedTension/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/ElasticCorrespondenceFullyPrescribedTension/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/ElasticHypoelasticCorrespondenceFullyPrescribedTension/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/ElasticBondAssociatedCorrespondenceFullyPrescribedTension/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/SimpleImplicitDiffusion/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/DiffusionImprovedQuadrature/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/InterfaceAwareDamageModel/cmake_install.cmake")
  include("/home/ashen/Documents/peridigm/test/verification/PredictorFromPreviousSolver/cmake_install.cmake")

endif()

