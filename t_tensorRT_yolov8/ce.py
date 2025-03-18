from ultralytics import YOLO
import cv2
import time


# 加载预训练的 YOLOv8 模型（.pt 文件）
model = YOLO('./yolov8n.pt')  # 请将 'yolov8n.pt' 替换为你实际的 .pt 文件路径


cap = cv2.VideoCapture("./mp4_out/ce1.mp4")

# 获取fps 每秒多少张图片
fps = int(cap.get(cv2.CAP_PROP_FPS))
# 获取视频图像宽、高
size = (int(cap.get(cv2.CAP_PROP_FRAME_WIDTH)), int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT)))
videoWriter = cv2.VideoWriter("out_n.mp4", cv2.VideoWriter_fourcc(*'mp4v'), fps, size)


num_time = 0
zhen_i = 0
while True:
    # print('xxx')
    zhen_i += 1
    t1 = cv2.getTickCount()
    ret, frame = cap.read()
    if not ret:
        break 
    image = cv2.resize(frame, (640, 640), cv2.INTER_LANCZOS4)
    t2 = cv2.getTickCount()
    t = (t2 - t1) / cv2.getTickFrequency()
    

    t3 = cv2.getTickCount()
    results = model(image, (640, 640),task='detect',device='cuda:0')
    # 处理检测结果
    for result in results:
        boxes = result.boxes  # 检测到的边界框信息
        masks = result.masks  # 检测到的掩码信息（如果模型支持）
        probs = result.probs  # 分类概率信息（如果是分类模型）

        # 获取图像
        img = result.orig_img

        # 在图像上绘制边界框
        for box in boxes:
            # 获取边界框的坐标
            xyxy = box.xyxy[0].cpu().numpy().astype(int)
            # 获取置信度
            conf = box.conf[0].cpu().numpy()
            # 获取类别索引
            cls_ = int(box.cls[0].cpu().numpy())

            # 在图像上绘制边界框
            cv2.rectangle(img, (xyxy[0], xyxy[1]), (xyxy[2], xyxy[3]), (0, 255, 0), 2)
            # 在图像上绘制类别标签和置信度
            cv2.putText(img, f'{cls_}: {conf:.2f}', (xyxy[0], xyxy[1] - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 0), 2)

    
    # 写入一帧
    videoWriter.write(fps)

    t4 = cv2.getTickCount()
    tt = (t4 - t3) / cv2.getTickFrequency()

    print(f"读取图像时间: {t*1000} 毫秒")
    print(f"处理运行时间: {tt*1000} 毫秒")
    ttt = (t4 - t1) / cv2.getTickFrequency()
    print(f"单个总时间: {ttt*1000} 毫秒")

    if zhen_i == 1:
        continue
    num_time += ttt

print(f"共{zhen_i-1}帧")
print(f"平均每帧处理时间 {(num_time / (zhen_i-1))*1000} 毫秒")
# 50.3804 毫秒

