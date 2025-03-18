# cd /root/UniSecurity/

# rm -r /root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/log*
# rm -r /root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/record_*
rm -r build
mkdir build
cd build
cmake ..
cd ..
cmake --build build 

./build/first_cmake


# ./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8m.onnx --fp16 --saveEngine=yolov8m_fp16.engine 

# python /root/UniSecurity/t_tensorRT_yolov8/zhuan_onnx_n.py
# python /root/UniSecurity/t_tensorRT_yolov8/zhuan_onnx_s.py
# python /root/UniSecurity/t_tensorRT_yolov8/zhuan_onnx_l.py
# python /root/UniSecurity/t_tensorRT_yolov8/zhuan_onnx_m.py
# python /root/UniSecurity/t_tensorRT_yolov8/zhuan_onnx_x.py