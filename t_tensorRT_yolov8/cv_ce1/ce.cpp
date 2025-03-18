#include <iostream>
#include <opencv2/opencv.hpp>

int main() {

    std::cout << "opencv 测试成功" << std::endl;

    // 读取视频：创建一个 videoCapture 对象，参数为视频路径
    cv::VideoCapture capture("/root/UniSecurity/t_tensorRT_yolov8/mp4_out/ce.mp4");
    // 判断视频是否读取成功，返回True代表成功
    if (!capture.isOpened())
    {
        std::cout << "无法读取视频：" << std::endl;
        return 1;
    }
    // 读取视频帧，使用Mat类型的frame存储返回的帧
    cv::Mat frame;
    // 循环读取视频帧
    while (true)
    {
        // 读取视频帧，使用 >> 运算符 或者 reda() 函数， 他的参数是返回的帧
        capture.read(frame);
        // capture >> frame

        // 判断是否读取成功
        if (frame.empty())
        {
            std::cout << "文件读取完毕" << std::endl;
            break;
        }

    return 0;
};
}