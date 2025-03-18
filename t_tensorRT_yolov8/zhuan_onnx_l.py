from ultralytics import YOLO

# 加载预训练的 YOLOv8 模型
# 请将 'yolov8n.pt' 替换为你实际的 .pt 文件路径
model = YOLO('/root/UniSecurity/t_tensorRT_yolov8/yolov8l.pt')

# 定义导出参数
export_params = {
    # 导出格式为 ONNX
    'format': 'onnx',
    # 输入图像的尺寸，这里设置为 640x640
    'imgsz': [640, 640],
    # 是否启用动态轴，设置为 True 允许输入图像的尺寸动态变化
    'dynamic': False,
    # 简化 ONNX 模型，去除不必要的节点和操作，使模型更简洁
    'simplify': False,
    # 导出模型时是否包含模型的符号表
    # 'opset': 12,  
    # 导出的 ONNX 文件路径，若不指定则默认在原模型同目录下生成同名的 .onnx 文件
    'save_dir': 'output_yolov8l.onnx',
    # 是否为半精度浮点数，设置为 True 可减少模型大小和推理时间，但可能会损失一定精度
    'half': False 
}

# 将模型导出为 ONNX 格式
success = model.export(**export_params)

if success:
    print("模型成功转换为 ONNX 格式。")
else:
    print("模型转换失败。")


# ./trtexec --onnx=/root/UniSecurity/yolov8_xun_lian/yolov8m.onnx --saveEngine=/root/UniSecurity/t_tensorRT_yolov8/yolov8m.engine