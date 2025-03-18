#!/bin/bash



# source /root/miniconda3/bin/activate
# conda activate py_17
# python /root/UniSecurity/t_tensorRT_yolov8/zhuan_onnx_n.py
# python /root/UniSecurity/t_tensorRT_yolov8/zhuan_onnx_s.py
# python /root/UniSecurity/t_tensorRT_yolov8/zhuan_onnx_l.py
# python /root/UniSecurity/t_tensorRT_yolov8/zhuan_onnx_m.py
# python /root/UniSecurity/t_tensorRT_yolov8/zhuan_onnx_x.py

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

# bash
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

# rm -r build
# mkdir build
# cd build
# cmake ..
# cd ..
# cmake --build build 

# ./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8m.onnx --fp16 --saveEngine=yolov8m_fp16.engine 

# 4090 cpp
# 代码运行时间: 0.0151536 秒
# 代码运行时间: 0.0148833 秒
# 代码运行时间: 0.0149174 秒
# 代码运行时间: 0.0151191 秒

# python
# 0: 640x640 1 person, 4.7ms
# Speed: 0.7ms preprocess, 4.7ms inference, 0.7ms postprocess per image at shape (1, 3, 640, 640)
# 以上代码运行时长： 0.014594676

# 0: 640x640 1 person, 4.7ms
# Speed: 0.7ms preprocess, 4.7ms inference, 0.7ms postprocess per image at shape (1, 3, 640, 640)
# 以上代码运行时长： 0.014829609

# 0: 640x640 1 person, 1 parking meter, 4.7ms
# Speed: 0.7ms preprocess, 4.7ms inference, 0.7ms postprocess per image at shape (1, 3, 640, 640)
# 以上代码运行时长： 0.014795448




# 3080
# 0: 640x640 1 person, 8.9ms
# Speed: 1.6ms preprocess, 8.9ms inference, 1.2ms postprocess per image at shape (1, 3, 640, 640)
# 代码运行时间: 0.012978553771972656 秒

# 0.01
# 0.007

# 初始化时间: 0.0177565 秒
# 传输 + 推理时间: 0.00427319 秒
# 后处理时间: 0.0034769 秒
# 代码运行时间: 0.0316483 毫秒

# 初始化时间: 0.0173757 秒
# 传输 + 推理时间: 0.0042539 秒
# 后处理时间: 0.00329079 秒  
# 代码运行时间: 0.0311329 毫秒



# 临时生效（仅当前终端）
# bash
# 复制
# # 假设库路径为 /usr/local/lib
# export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

# 永久生效
# bash
# 复制
# # 创建配置文件
# sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'

# # 更新动态链接器缓存
# sudo ldconfig