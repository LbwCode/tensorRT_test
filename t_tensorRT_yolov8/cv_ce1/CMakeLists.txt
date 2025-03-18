# CMakeLists.txt cmake文件名大小写不敏感

#指定cmake最低版本
cmake_minimum_required(VERSION 3.20)

#构建项目的名称
project(xlog)

# 查找库 
find_package(OpenCV REQUIRED)

#构建执行程序 构建来源于
add_executable(
    xlog
    ce.cpp
)
#执行程序依赖库
target_link_libraries(
    xlog
    PRIVATE ${OpenCV_LIBS}  
)
# 查找库时：OpenCV REQUIRED ${OpenCV_LIBS} 这些参数都是官方给的
