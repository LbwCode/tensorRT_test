cd /root/UniSecurity/t_tensorRT_yolov8/ce_r_v
rm -r build
mkdir build
cd build
cmake ..
cd ..
cmake --build build 
./build/xlog