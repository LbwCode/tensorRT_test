#include "yolov8_trt_demo.h"

std::string labels_txt_file = "/root/UniSecurity/t_tensorRT_yolov8/c80.txt";
// std::vector<std::string> readClassNames();
std::vector<std::string> readClassNames()
{
	std::vector<std::string> classNames;

	std::ifstream fp(labels_txt_file);
	if (!fp.is_open())
	{
		printf("could not open file...\n");
		exit(-1);
	}
	std::string name;
	while (!fp.eof())
	{
		std::getline(fp, name);
		if (name.length())
			classNames.push_back(name);
	}
	fp.close();
	return classNames;
}

int main(int argc, char** argv) {

	// 指定使用的 GPU 设备编号，编号从 0 开始
    int device_id = 0;  // 这里指定使用第一块显卡
    cudaError_t err = cudaSetDevice(device_id);

	if (err != cudaSuccess) {
        std::cerr << "cudaSetDevice 出错，错误代码: " << cudaGetErrorString(err) << std::endl;
        return -1;
    }

	// 获取当前设备信息
    cudaDeviceProp deviceProp;
    cudaGetDeviceProperties(&deviceProp, device_id);
    std::cout << "当前使用的 GPU 设备: " << deviceProp.name << std::endl;
	
    


	std::vector<std::string> labels = readClassNames();
	std::string enginefile = "/root/UniSecurity/t_tensorRT_yolov8/yolov8m.engine";
	
	std::string videoPath = "/root/UniSecurity/t_tensorRT_yolov8/mp4_out/ce.mp4";
	// 检测
    std::ifstream file(videoPath);
    if (!file.good()) {
        std::cerr << "视频文件不存在或路径错误: " << videoPath << std::endl;
        return -1;
    }

	cv::VideoCapture cap(videoPath);
	// 写入MP4文件，参数分别是：文件名，编码格式，帧率，帧大小  
	cv::VideoWriter writer("record.mp4", cv::VideoWriter::fourcc('m','p','4','v'), 30, cv::Size(1920, 1080));

	std::cout << "获取视频帧数 " << std::endl;
	// 获取视频总帧数
    int totalFrames = cap.get(cv::CAP_PROP_FRAME_COUNT);
	std::cout << "获取成功 " << std::endl;
	cv::Mat frame;
	auto detector = std::make_shared<YOLOv8TRTDetector>();
	std::cout << "初始化 " << std::endl;

	int i_num = 0;
	detector->initConfig(enginefile, 0.25, 0.25);
	std::cout << "设置 " << std::endl;

	std::vector<DetectResult> results;

	while (true) {
		i_num++;
		if (i_num >= totalFrames){
			std::cout << "总帧数多少: "<< totalFrames << std::endl;
			break;
		}
		// std::cout << "代码运行 " << std::endl;
		auto start = std::chrono::high_resolution_clock::now();

		bool ret = cap.read(frame);
		if (frame.empty()) {
			std::cout << "没图像" << std::endl;
			continue;
		}

		detector->detect(frame, results);

		for (DetectResult dr : results) {
			cv::Rect box = dr.box;
			cv::putText(frame, labels[dr.classId], cv::Point(box.tl().x, box.tl().y - 10), cv::FONT_HERSHEY_SIMPLEX, .5, cv::Scalar(0, 0, 0));
			// cv::imwrite("/root/UniSecurity/t_tensorRT_yolov8/test_out.jpg", frame);
			// 写入视频
	 		writer.write(frame);
		}
	
		// 计算时间
		auto end = std::chrono::high_resolution_clock::now();
		std::chrono::duration<double, std::milli> elapsed = end - start;  // 计算时间差并以毫秒为单位
		std::cout << "代码运行时间: " << elapsed.count() << " 毫秒" << std::endl;

		//cv::imshow("YOLOv8 + TensorRT8.6 对象检测演示", frame);
		//char c = cv::waitKey(1);
		//if (c == 27) { // ESC 退出
		//	break;
		//}
		// reset for next frame
		results.clear();
	}
	return 0;
}