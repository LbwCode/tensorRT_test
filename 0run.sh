

# sudo docker exec -it yolo-bowen1 /bin/bash
# source /root/miniconda3/bin/activate;conda activate py_17

#!/bin/bash
# bash run.sh

# docker load --input name20250306.tar
# sudo docker run -itd --gpus all --network=host --name yolo-bowen1 -v /home/featurize/work:/root/UniSecurity/ 3dddf9e4441b

cat > /tmp/container_script.sh <<'EOF'
#!/bin/bash
# 容器内执行的脚本内容
rm -r log*

# 进入 python 环境
source /root/miniconda3/bin/activate;conda activate py_17
# 转onnx
python /root/UniSecurity/t_tensorRT_yolov8/zhuan_onnx_n.py
python /root/UniSecurity/t_tensorRT_yolov8/zhuan_onnx_s.py
python /root/UniSecurity/t_tensorRT_yolov8/zhuan_onnx_l.py
python /root/UniSecurity/t_tensorRT_yolov8/zhuan_onnx_m.py
python /root/UniSecurity/t_tensorRT_yolov8/zhuan_onnx_x.py

# 测试 python 速度
python /root/UniSecurity/t_tensorRT_yolov8/ce1.py

# cd /root/UniSecurity/t_tensorRT_yolov8_cuda/

# # 强制 Python 无缓冲输出（关键！）
# python -u ce.py  # 注意 -u 参数

rm /root/UniSecurity/t_tensorRT_yolov8/*.eng*
# rm /root/UniSecurity/t_tensorRT_yolov8/*.engine 
# rm /root/UniSecurity/t_tensorRT_yolov8/yolov8m_fp16.engine 
# rm /root/UniSecurity/t_tensorRT_yolov8/yolov8m.engine 
# rm /root/UniSecurity/t_tensorRT_yolov8/yolov8n_fp16.engine 
# rm /root/UniSecurity/t_tensorRT_yolov8/yolov8n.engine 

rm /root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/*.eng*
# rm /root/UniSecurity/t_tensorRT_yolov8_cuda/*.engine 
# rm /root/UniSecurity/t_tensorRT_yolov8_cuda/yolov8m_fp16.engine 
# rm /root/UniSecurity/t_tensorRT_yolov8_cuda/yolov8m.engine 
# rm /root/UniSecurity/t_tensorRT_yolov8_cuda/yolov8n_fp16.engine 
# rm /root/UniSecurity/t_tensorRT_yolov8_cuda/yolov8n.engine 



# 关键：添加 TensorRT 库路径
export LD_LIBRARY_PATH=/usr/local/TensorRT-8.6.0.12/lib:$LD_LIBRARY_PATH

cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8n.onnx --fp16 --saveEngine=yolov8n_fp16.engine 
cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8n.onnx --saveEngine=yolov8n.engine 

cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8s.onnx --fp16 --saveEngine=yolov8s_fp16.engine 
cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8s.onnx --saveEngine=yolov8s.engine 

cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8l.onnx --fp16 --saveEngine=yolov8l_fp16.engine 
cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8l.onnx --saveEngine=yolov8l.engine 

cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8m.onnx --fp16 --saveEngine=yolov8m_fp16.engine 
cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8m.onnx --saveEngine=yolov8m.engine 

cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8x.onnx --fp16 --saveEngine=yolov8x_fp16.engine 
cd /usr/local/TensorRT-8.6.0.12/;./bin/trtexec --onnx=/root/UniSecurity/t_tensorRT_yolov8/yolov8x.onnx --saveEngine=yolov8x.engine 


cp /usr/local/TensorRT-8.6.0.12/yolov8* /root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/
cp /usr/local/TensorRT-8.6.0.12/yolov8* /root/UniSecurity/t_tensorRT_yolov8/

cd /root/UniSecurity/t_tensorRT_yolov8_cuda/
unzip opencv-4.5.0
unzip opencv_contrib
mv opencv-4.5.0 opencv
mv opencv_contrib-4.5.0 opencv_contrib
cp cp -r .cache/.cache/ ./opencv/.cache

cd /root/UniSecurity/t_tensorRT_yolov8_cuda/opencv
rm -r build
mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=/usr/local \
            -D WITH_TBB=ON \
            -D BUILD_TBB=ON \
            -D ENABLE_FAST_MATH=1 \
            -D CUDA_FAST_MATH=1 \
            -D WITH_CUBLAS=1 \
            -D WITH_V4L=ON \
            -D WITH_LIBV4L=ON \
            -D WITH_CUDA=ON \
            -D WITH_CUDNN=ON \
            -D WITH_CUDEV=ON \
            -D WITH_GTK_2_X=ON \
            -D WITH_NVCUVID=ON \
            -D CUDA_ARCH_BIN=Auto \
            -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
            -D WITH_OPENGL=ON \
            -D WITH_FFMPEG=ON \
            -D OPENCV_GENERATE_PKGCONFIG=YES \
            ..

make -j8

make install

sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'

ldconfig


# 测试 tensorRT
# cd /usr/local/TensorRT-8.6.0.12/samples/sampleOnnxMNIST
# make; ../../bin/sample_onnx_mnist
# cmake -D CMAKE_BUILD_TYPE=Release -D OPENCV_GENERATE_PKGCONFIG=YES -D WITH_GTK=ON ..

# 测试 cuda-opencv + tensorRT 速度 

rm -r /root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/log*
rm -r /root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/record_*

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

cp /root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/log*.txt /root/UniSecurity/

cp /root/UniSecurity/t_tensorRT_yolov8/python_log.txt /root/UniSecurity/python_log.txt

EOF

# 步骤2：复制到容器内（路径对应）
docker cp /tmp/container_script.sh yolo-bowen1:/tmp/  # 目标路径改为 /tmp
docker exec yolo-bowen1 chmod +x /tmp/container_script.sh

# 步骤3：执行并实时显示输出（优化命令）
echo "开始执行容器内脚本..."
docker exec -it yolo-bowen1 /bin/bash -c "cd /tmp && ./container_script.sh 2>&1"


