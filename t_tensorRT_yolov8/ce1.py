from ultralytics import YOLO
import cv2
import time
import numpy as np

import logging

# 配置logging模块
logging.basicConfig(
    level=logging.INFO,  # 设置日志级别为INFO，只记录INFO及以上级别的日志
    format='%(asctime)s - %(levelname)s - %(message)s',  # 设置日志格式
    handlers=[
        logging.FileHandler('/root/UniSecurity/t_tensorRT_yolov8/python_log.txt'),  # 将日志写入log.txt文件
        logging.StreamHandler()  # 同时在控制台输出日志
    ]
)
# # 记录日志
# logging.debug('这是一条调试日志')
# logging.info('这是一条信息日志')
# logging.warning('这是一条警告日志')
# logging.error('这是一条错误日志')
# logging.critical('这是一条严重错误日志')

def run(pt_name, mp4_name):
    # 加载预训练的 YOLOv8 模型
    model = YOLO(pt_name)  # 请确认模型路径正确

    # 视频输入输出配置
    cap = cv2.VideoCapture("/root/UniSecurity/t_tensorRT_yolov8/mp4_out/ce1.mp4")
    orig_w = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))  # 原始宽度
    orig_h = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT)) # 原始高度
    fps = int(cap.get(cv2.CAP_PROP_FPS))

    # 视频写入器（保持原始分辨率）
    videoWriter = cv2.VideoWriter(
        mp4_name,
        cv2.VideoWriter_fourcc(*'mp4v'),
        fps,
        (orig_w, orig_h)
    )

    # 性能统计变量
    total_frames = 0
    total_processing_time = 0

    n1 = 0
    while True:
        n1 += 1
        start_time = time.time()
        
        # 读取帧 ----------------------------------------------------------
        ret, frame = cap.read()
        if not ret:
            break
        
        # 缩放图像用于推理 ------------------------------------------------
        resized_frame = cv2.resize(frame, (640, 640), interpolation=cv2.INTER_LANCZOS4)
        
        # 执行推理 --------------------------------------------------------
        results = model(resized_frame, imgsz=640, task='detect', device='cuda:0')
        
        # 处理检测结果 ----------------------------------------------------
        for result in results:
            boxes = result.boxes.cpu().numpy()
            
            # 创建绘制画布（使用原始帧，保持色彩空间一致）
            # draw_frame = frame.copy()
            
            # 遍历所有检测框
            for box in boxes:
                # 获取坐标（基于640x640尺寸）
                x1, y1, x2, y2 = map(int, box.xyxy[0])
                conf = box.conf[0]
                cls_id = int(box.cls[0])
                
                # 坐标转换：640x640 -> 原始尺寸
                scale_x = orig_w / 640
                scale_y = orig_h / 640
                x1_orig = int(x1 * scale_x)
                y1_orig = int(y1 * scale_y)
                x2_orig = int(x2 * scale_x)
                y2_orig = int(y2 * scale_y)
                
                # # 在原始帧上绘制
                # cv2.rectangle(draw_frame, 
                #              (x1_orig, y1_orig),
                #              (x2_orig, y2_orig),
                #              (0, 255, 0), 2)
                
                # # 绘制标签
                # label = f"{model.names[cls_id]}: {conf:.2f}"
                # cv2.putText(draw_frame, label,
                #             (x1_orig, y1_orig - 10),
                #             cv2.FONT_HERSHEY_SIMPLEX, 0.7,
                #             (0, 255, 0), 2, cv2.LINE_AA)
            
            # 写入处理后的帧
            # videoWriter.write(draw_frame)
        
        # 性能统计 --------------------------------------------------------
        processing_time = time.time() - start_time

        if n1 == 1:
            total_processing_time = 0
            continue
        total_processing_time += processing_time
        total_frames += 1
        
        # 控制台输出
        print(f"Frame {total_frames} processed in {processing_time*1000:.2f}ms")

    # 释放资源 ------------------------------------------------------------
    cap.release()
    videoWriter.release()

    # 输出统计结果
    if total_frames > 0:
        avg_time = total_processing_time / total_frames
        print(f"\n处理完成！共处理 {total_frames} 帧")
        print(f"平均每帧处理时间: {avg_time*1000:.2f}ms")
        print(f"平均帧率: {1/avg_time:.2f}FPS")

        return avg_time*1000
    else:
        print("错误：未处理任何帧！")

    


pt_name = '/root/UniSecurity/t_tensorRT_yolov8/yolov8m.pt'
mp4_name = "/root/UniSecurity/t_tensorRT_yolov8/out_m.mp4"
tim1 = run(pt_name, mp4_name)

logging.info(" yolov8m 平均每帧处理时间:" + str(tim1))

pt_name = '/root/UniSecurity/t_tensorRT_yolov8/yolov8n.pt'
mp4_name = "/root/UniSecurity/t_tensorRT_yolov8out_n.mp4"
tim2 = run(pt_name, mp4_name)
logging.info(" yolov8n 平均每帧处理时间:" + str(tim2))