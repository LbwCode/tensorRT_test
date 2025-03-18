# cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8n.onnx --fp16 --saveEngine=yolov8n_fp16.engine 
# cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8n.onnx --saveEngine=yolov8n.engine 

# cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8s.onnx --fp16 --saveEngine=yolov8s_fp16.engine 
# cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8s.onnx --saveEngine=yolov8s.engine 

# cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8l.onnx --fp16 --saveEngine=yolov8l_fp16.engine 
# cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8l.onnx --saveEngine=yolov8l.engine 

# cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8m.onnx --fp16 --saveEngine=yolov8m_fp16.engine 
# cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8m.onnx --saveEngine=yolov8m.engine 

# cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8x.onnx --fp16 --saveEngine=yolov8x_fp16.engine 
# cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8x.onnx --saveEngine=yolov8x.engine 


cd /root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/
rm -r build
mkdir build
cd build
cmake ..
cd ..
cmake --build build 

./build/first_cmake logn.txt \
 "/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/c80.txt" \
 /root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/yolov8n.engine \
 /root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/ce.mp4 \
 /root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/record_n.mp4

./build/first_cmake logn_fp16.txt \
"/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/c80.txt" \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/yolov8n_fp16.engine \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/ce.mp4 \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/record_n_fp16.mp4


./build/first_cmake logs.txt \
"/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/c80.txt" \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/yolov8s.engine \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/ce.mp4 \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/record_s.mp4

./build/first_cmake logs_fp16.txt \
"/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/c80.txt" \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/yolov8s_fp16.engine \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/ce.mp4 \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/record_s_fp16.mp4

./build/first_cmake logl.txt \
"/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/c80.txt" \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/yolov8l.engine \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/ce.mp4 \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/record_l.mp4

./build/first_cmake logl_fp16.txt \
"/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/c80.txt" \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/yolov8l_fp16.engine \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/ce.mp4 \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/record_l_fp16.mp4

./build/first_cmake logm.txt \
"/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/c80.txt" \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/yolov8m.engine \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/ce.mp4 \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/record_m.mp4

./build/first_cmake logm_fp16.txt \
"/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/c80.txt" \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/yolov8m_fp16.engine \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/ce.mp4 \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/record_m_fp16.mp4

./build/first_cmake logx.txt \
"/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/c80.txt" \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/yolov8x.engine \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/ce.mp4 \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/record_x.mp4

./build/first_cmake logx_fp16.txt \
"/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/c80.txt" \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/yolov8x_fp16.engine \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/ce.mp4 \
/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/record_x_fp16.mp4