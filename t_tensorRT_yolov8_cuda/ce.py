import torch

if torch.cuda.is_available():
    major, minor = torch.cuda.get_device_capability()
    arch_bin = f"{major}.{minor}"
    print(arch_bin)
else:
    print("CUDA is not available.")