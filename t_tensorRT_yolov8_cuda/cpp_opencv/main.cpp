#include "yolov8_cuda_trt.h"
#include <cstdio>


std::vector<std::string> readClassNames(std::string labels_txt_file)
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

int main(int argc, char* argv[]) {
	// /root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/c80.txt
	// /root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/yolov8n.engine
	// /root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/ce.mp4
	// /root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/record_n.mp4

	// 将标准输出重定向到log.txt文件
    std::freopen(argv[1], "w", stdout);
    // std::cout << "这是一条测试日志。" << std::endl;
    // 关闭重定向
    // std::fclose(stdout);
	
	std::vector<std::string> labels = readClassNames(argv[2]);
	// std::string labels_txt_file = "/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/c80.txt";
	// std::vector<std::string> labels = readClassNames(labels_txt_file);
	std::string enginefile = argv[3];

	cv::Mat frame;
	auto detector = std::make_shared<YOLOv8TRTDetector>();
	detector->initConfig(enginefile, 0.25, 0.25);
	std::vector<DetectResult> results;

	std::string videoPath = argv[4];
	// std::string videoPath = "/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/ce.mp4";
	// 检测
    std::ifstream file(videoPath);
    if (!file.good()) {
        std::cerr << "视频文件不存在或路径错误: " << videoPath << std::endl;
        return -1;
    }

	cv::VideoCapture cap(videoPath);
	// 写入MP4文件，参数分别是：文件名，编码格式，帧率，帧大小  
	cv::VideoWriter writer(argv[5], cv::VideoWriter::fourcc('m','p','4','v'), 30, cv::Size(1920, 1080));
	// cv::VideoWriter writer("/root/UniSecurity/t_tensorRT_yolov8_cuda/cpp_opencv/record_n.mp4", cv::VideoWriter::fourcc('m','p','4','v'), 30, cv::Size(1920, 1080));

	std::cout << "获取视频帧数 " << std::endl;
	// 获取视频总帧数
    int totalFrames = cap.get(cv::CAP_PROP_FRAME_COUNT);
	std::cout << "获取成功 " << std::endl;

	double num_time = 0.0;
	int num_i = 0;

	while (true) {

		num_i ++;
		int64 start4 = cv::getTickCount();

		bool ret = cap.read(frame);
		if (frame.empty()) {
			break;
		}

		float t4 = (cv::getTickCount() - start4) / static_cast<float>(cv::getTickFrequency());
		
		int64 start5 = cv::getTickCount();

		// auto start = std::chrono::high_resolution_clock::now();
		detector->detect(frame, results);
		for (DetectResult dr : results) {
			cv::Rect box = dr.box;
			// cv::putText(frame, labels[dr.classId], cv::Point(box.tl().x, box.tl().y - 10), cv::FONT_HERSHEY_SIMPLEX, .5, cv::Scalar(0, 0, 0));
		}
		// 写入视频
		// writer.write(frame);

		// auto end = std::chrono::high_resolution_clock::now();
		// std::chrono::duration<double, std::milli> elapsed = end - start;  // 计算时间差并以毫秒为单位
		// std::cout << "代码运行时间: " << elapsed.count()/1000.0 << " 毫秒" << std::endl;
		results.clear();


		// 计算FPS render it
		if (num_i == 1){
			continue;
		}

		std::cout << "读图时间: " << t4*1000.0 << " 毫秒" << std::endl;
		float t5 = (cv::getTickCount() - start5) / static_cast<float>(cv::getTickFrequency());
		std::cout << "处理时间: " << t5*1000.0 << " 毫秒" << std::endl;

		float t6 = (cv::getTickCount() - start4) / static_cast<float>(cv::getTickFrequency());
		std::cout << "单帧总时间: " << t6*1000.0 << " 毫秒" << std::endl;

		num_time = num_time + t6;

		// // 写一次日志
		// if (num_i == 2){

		// }
		
		
		//cv::imshow("YOLOv8 + TensorRT8.6 对象检测演示", frame);
		//char c = cv::waitKey(1);
		//if (c == 27) { // ESC 退出
		//	break;
		//}
		// reset for next frame
		
	}

	std::cout << "总帧数: " << totalFrames-1 << std::endl;
	std::cout << "平均每帧处理时间: " << num_time / (totalFrames-1) * 1000.0 << " 毫秒" << std::endl;

	// 获取当前时间点
    auto now = std::chrono::system_clock::now();
    // 将时间点转换为时间戳
    std::time_t currentTime = std::chrono::system_clock::to_time_t(now);
    // 输出时间，使用 put_time 进行格式化
    std::cout << "当前时间: " 
              << std::put_time(std::localtime(&currentTime), "%Y-%m-%d %H:%M:%S") 
              << std::endl;
	std::cout << argv[3] << std::endl;
	// 关闭重定向
    // std::fclose(stdout);

	return 0;
}