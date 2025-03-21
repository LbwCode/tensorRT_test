用于个人测试使用的，在docker镜像中测试yolov8在不同显卡上的加速效果
本配置为ubuntru20.04系统
主要于python与C++的速度对比
python环境使用 minni conda3的虚拟环境
c++ 使用cmake构建，主要环境为：TensorRT-8.6.0.12 + cuda 11.6

存在两个文件夹，一个是的opencv是有cuda加速的，需要重新编译opencv 4.5.0 ,经过测试使用这个进行加速才有意义。

![image](https://github.com/user-attachments/assets/7f3247b8-f02b-4dd5-9794-a1cc9f39712f)

![image](https://github.com/user-attachments/assets/42931506-707d-40be-9a10-accdea18bc55)

![image](https://github.com/user-attachments/assets/a422b604-3ba5-4496-84f0-1e701c3272aa)

![image](https://github.com/user-attachments/assets/95cbf11c-4239-40ca-a4e5-b5c5f79d684b)

![image](https://github.com/user-attachments/assets/957a1e95-c898-473c-86cd-b77a62fcb7ef)

