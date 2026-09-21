dnf -y install python3-pip python3-devel gcc gcc-c++ make jq
dnf -y install python3.14
python -m ensurepip
python -m pip install -U pip
python -m venv --system-site-packages ~/llama
source ~/llama/bin/activate
python -m pip install uv
python -m uv tool install hf
