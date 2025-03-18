#include "yolov8_trt_demo.h"


// std::vector<std::string> readClassNames();
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
	
    //sudo docker run -itd --gpus all --network=host --name yolo-bowen1 -v /home/featurize/work/t_tensorRT_yolov8:/root/UniSecurity/ c483ef84e377

	std::string labels_txt_file = "/root/UniSecurity/t_tensorRT_yolov8/c80.txt";
	std::vector<std::string> labels = readClassNames(labels_txt_file);
	std::string enginefile = "/root/UniSecurity/t_tensorRT_yolov8/yolov8n.engine";
	
	std::string videoPath = "/root/UniSecurity/t_tensorRT_yolov8/mp4_out/ce1.mp4";
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

	detector->initConfig(enginefile, 0.25, 0.25);
	std::cout << "设置 " << std::endl;

	std::vector<DetectResult> results;
	// auto start = std::chrono::high_resolution_clock::now();
	// int64 start = cv::getTickCount();

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
		// cv::putText(frame, cv::format("FPS: %.2f", 1.0 / t), cv::Point(20, 40), cv::FONT_HERSHEY_PLAIN, 2.0, cv::Scalar(255, 0, 0), 2, 8);
		
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
		
		//cv::imshow("YOLOv8 + TensorRT8.6 对象检测演示", frame);
		//char c = cv::waitKey(1);
		//if (c == 27) { // ESC 退出
		//	break;
		//}
		// reset for next frame
		
	}

	std::cout << "总帧数: " << totalFrames-1 << std::endl;
	std::cout << "平均每帧处理时间: " << num_time / (totalFrames-1) * 1000.0 << " 毫秒" << std::endl;
	

	return 0;
}