# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# The workflow only lists unknown_registry custom nodes and none include an aux_id (GitHub repo).
# Therefore we cannot install any of these automatically. Please provide aux_id (GitHub owner/repo)
# for any of the following if you want them cloned automatically:
# - Anything Everywhere
# - LatentUpscaleBy
# - SeedVR2LoadVAEModel
# - SeedVR2LoadDiTModel
# - ImageScaleBy
# - SeedVR2VideoUpscaler
# - LoraLoaderModelOnly
# - GrokImageAnalyzer
# - PreviewAny

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/diffusion_models/z_image_turbo_bf16.safetensors --relative-path models/diffusion_models --filename z_image_turbo_bf16.safetensors

RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/text_encoders/qwen_3_4b.safetensors --relative-path models/clip --filename qwen_3_4b.safetensors

RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/vae/ae.safetensors --relative-path models/vae --filename ae.safetensors

RUN comfy model download --url https://huggingface.co/numz/SeedVR2_comfyUI/resolve/main/ema_vae_fp16.safetensors --relative-path models/vae --filename ema_vae_fp16.safetensors

RUN comfy model download --url https://huggingface.co/cmeka/SeedVR2-GGUF/resolve/main/seedvr2_ema_3b-Q4_K_M.gguf --relative-path models/upscale_models --filename seedvr2_ema_3b-Q4_K_M.gguf

RUN comfy model download --url https://huggingface.co/jeremyhola/LORAs/resolve/main/LilyStone/zImage/ostris-ai-toolkit/02-02-26_3-50PM/lily-ztubo-lora-v1.safetensors --relative-path models/lora --filename lily-ztubo-lora-v1.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
