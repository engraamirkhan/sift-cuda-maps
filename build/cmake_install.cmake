# Install script for directory: C:/Users/cuevision/Documents/CudaSift-Maxwell

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Program Files/cudaSift")
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

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/." TYPE FILE FILES
    "C:/Users/cuevision/Documents/CudaSift-Maxwell/cudaImage.cu"
    "C:/Users/cuevision/Documents/CudaSift-Maxwell/cudaImage.h"
    "C:/Users/cuevision/Documents/CudaSift-Maxwell/cudaSiftH.cu"
    "C:/Users/cuevision/Documents/CudaSift-Maxwell/cudaSiftH.h"
    "C:/Users/cuevision/Documents/CudaSift-Maxwell/matching.cu"
    "C:/Users/cuevision/Documents/CudaSift-Maxwell/cudaSiftD.h"
    "C:/Users/cuevision/Documents/CudaSift-Maxwell/cudaSift.h"
    "C:/Users/cuevision/Documents/CudaSift-Maxwell/cudautils.h"
    "C:/Users/cuevision/Documents/CudaSift-Maxwell/geomFuncs.cpp"
    "C:/Users/cuevision/Documents/CudaSift-Maxwell/mainSift.cpp"
    "C:/Users/cuevision/Documents/CudaSift-Maxwell/cudaSiftD.cu"
    "C:/Users/cuevision/Documents/CudaSift-Maxwell/CMakeLists.txt"
    "C:/Users/cuevision/Documents/CudaSift-Maxwell/Copyright.txt"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/data" TYPE FILE FILES
    "C:/Users/cuevision/Documents/CudaSift-Maxwell/data/left.pgm"
    "C:/Users/cuevision/Documents/CudaSift-Maxwell/data/righ.pgm"
    )
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "C:/Users/cuevision/Documents/CudaSift-Maxwell/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
