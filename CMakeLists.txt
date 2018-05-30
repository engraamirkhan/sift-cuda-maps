cmake_minimum_required(VERSION 2.6)

project(cudaSift)
set(cudaSift_VERSION_MAJOR 2)
set(cudaSift_VERSION_MINOR 0)
set(cudaSift_VERSION_PATCH 0)
SET("OpenCV_DIR" "C:/Users/cuevision/Documents/opencv-3.4.1/build")
#SET("cuda_LIBS" "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v9.1/lib/x64/")
set(CPACK_PACKAGE_VERSION_MAJOR "${cudaSift_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${cudaSift_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${cudaSift_VERSION_PATCH}")
set(CPACK_GENERATOR "ZIP")
include(CPack)
#set(OpenCV_DIR "C:\Users\cuevision\Documents\opencv-3.4.1\build")
find_package(OpenCV REQUIRED)
SET(CUDA_SEPARABLE_COMPILATION ON)
set(CUDA_USE_STATIC_CUDA_RUNTIME OFF)
find_package(CUDA)
if (NOT CUDA_FOUND)
  message(STATUS "CUDA not found. Project will not be built.")
endif(NOT CUDA_FOUND)

if (WIN64)
  set(EXTRA_CXX_FLAGS "/DVERBOSE /D_CRT_SECURE_NO_WARNINGS ")
  #list(APPEND CUDA_NVCC_FLAGS "-arch=sm_50;--compiler-options;-O2;-DVERBOSE;") 
endif()
if (UNIX)
  if (APPLE)
    set(EXTRA_CXX_FLAGS "-DVERBOSE -msse2")
    list(APPEND CUDA_NVCC_FLAGS "-arch=sm_35;--compiler-options;-O2;-DVERBOSE") 
  else()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O2 -msse2 ")
    list(APPEND CUDA_NVCC_FLAGS "-lineinfo;--compiler-options;-O2;-DVERBOSE") 
  endif()
endif()


set(CMAKE_CXX_STANDARD 11)
if(MSVC)
	add_definitions(-DCONSTEXPR=const -DNOMINMAX -D_CRT_SECURE_NO_WARNINGS)
else()
	add_definitions(-DCONSTEXPR=constexpr)
	set(CXX_WARNINGS "-Wall -Wextra -Wpointer-arith -Wcast-align -fstrict-aliasing -Wno-unused-local-typedefs -Wno-misleading-indentation -Wno-maybe-uninitialized -Wno-int-in-bool-context -Wno-implicit-fallthrough")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CXX_WARNINGS} -fvisibility-inlines-hidden -O3")
endif()


set(CMAKE_CUDA_STANDARD 11)
set(
    CUDA_NVCC_FLAGS
    ${CUDA_NVCC_FLAGS};
    -O3 -gencode arch=compute_50,code=sm_50
    )

set(cuda_sources
  # dynamic.cu
  cudaImage.cu  
  cudaImage.h  
  cudaSiftH.cu 
  cudaSiftH.h  
  matching.cu  
  cudaSiftD.h  
  cudaSift.h  
  cudautils.h
)  

set(sources
  geomFuncs.cpp  
  mainSift.cpp
)

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR} 
)



cuda_add_executable(cudasift ${cuda_sources} ${sources} )

set_property(TARGET cudasift PROPERTY CUDA_STANDARD 11)

set_target_properties(cudasift PROPERTIES
  CUDA_RESOLVE_DEVICE_SYMBOLS ON
  POSITION_INDEPENDENT_CODE ON
  CUDA_SEPARABLE_COMPILATION ON
  COMPILE_FLAGS "${EXTRA_CXX_FLAGS}"			   
)

target_link_libraries(cudasift cudadevrt.lib ${CUDA_LIBRARIES} ${OpenCV_LIBS} 

#  "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v9.1/lib/x64/libcudadevrt"
)
 
install(FILES 
  ${cuda_sources} 
  ${sources}
  cudaSiftD.cu
  CMakeLists.txt
  Copyright.txt
  DESTINATION .
)
install(FILES data/left.pgm data/righ.pgm
  DESTINATION data
)
