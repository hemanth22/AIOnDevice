#!/bin/bash
echo "[TASK 1] Install pre-requiste for AI on Device"
dnf -y install python3-pip python3-devel gcc gcc-c++ make jq
echo "[TASK 2] Ensure to install python and configure"
dnf -y install python3.14
python -m ensurepip
python -m pip install -U pip
echo "[TASK 3] Start in python virtual environment"
python -m venv --system-site-packages ~/llama
source ~/llama/bin/activate
python -m pip install uv
echo "[TASK 4] Download Small AI model"
wget https://huggingface.co/bartowski/Qwen_Qwen3-0.6B-GGUF/resolve/main/Qwen_Qwen3-0.6B-Q4_K_M.gguf
echo "[TASK 5] Start AI model with Python"
python -m llama_cpp.server --model ./Qwen_Qwen3-0.6B-Q4_K_M.gguf --host 0.0.0.0 --port 8000 &
echo "[TASK 6] Verify AI commandline"
curl -s -XPOST -H 'Content-Type: application/json' localhost:8000/v1/chat/completions \
-d '{"messages": [{"role": "user", "content": "Introduce yourself."}]}' | jq
curl -s -XPOST -H 'Content-Type: application/json' localhost:8000/v1/chat/completions \
-d '{"messages": [{"role": "user", "content": "Tell me about Hiroshima city, Japan."}]}' | jq | sed -e 's/\\n/\n/g'
