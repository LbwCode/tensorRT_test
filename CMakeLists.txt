
cmake_minimum_required(VERSION 3.20)
project(first_cmake)

# 查找 OpenCV
find_package(OpenCV REQUIRED)
message(STATUS "OpenCV version: ${OpenCV_VERSION}")
message(STATUS "OpenCV libraries: ${OpenCV_LIBS}")
message(STATUS "OpenCV include path: ${OpenCV_INCLUDE_DIRS}")

# 查找 CUDA
find_package(CUDA REQUIRED)
message(STATUS "CUDA version: ${CUDA_VERSION}")
message(STATUS "CUDA libraries: ${CUDA_LIBRARIES}")
message(STATUS "CUDA include path: ${CUDA_INCLUDE_DIRS}")

# 查找线程库
find_package(Threads REQUIRED)

# 递归收集 src 目录下的所有 .cpp 源文件
file(GLOB_RECURSE my_lib_sources "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp")

# 导入库，使用合适的库名称
add_library(my_library ${my_lib_sources})

# 头文件搜索路径
# 让 a.cpp b.cpp c.cpp 可以找到头文件 MyLib1.h
target_include_directories(
    my_library
    PUBLIC include
    PUBLIC ${OpenCV_INCLUDE_DIRS}  # 添加 OpenCV 头文件搜索路径
    PUBLIC ${CUDA_INCLUDE_DIRS}    # 添加 CUDA 头文件搜索路径
)

# 设置 TensorRT 路径
set(TENSORRT_INCLUDE_DIR "/usr/local/TensorRT-8.6.0.12/include")
set(TENSORRT_LIBRARY_DIR "/usr/local/TensorRT-8.6.0.12/lib")

# 包含 TensorRT 头文件路径
target_include_directories(
    my_library
    PUBLIC ${TENSORRT_INCLUDE_DIR}
)

# 链接 TensorRT 库路径
link_directories(${TENSORRT_LIBRARY_DIR})

# 添加可执行文件
add_executable(first_cmake main.cpp)

# 链接库，避免重复使用 PUBLIC 关键字
target_link_libraries(
    first_cmake
    PUBLIC my_library
    ${OpenCV_LIBS}
    Threads::Threads
    nvinfer
    nvinfer_plugin
    ${CUDA_LIBRARIES}
)

# 包含头文件目录
target_include_directories(
    first_cmake
    PRIVATE ${OpenCV_INCLUDE_DIRS}
    PRIVATE ${CUDA_INCLUDE_DIRS}
    PRIVATE ${TENSORRT_INCLUDE_DIR}
)

