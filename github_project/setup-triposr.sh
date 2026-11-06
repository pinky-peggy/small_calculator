#!/usr/bin/env bash
# 为 github_project/TripoSR 创建虚拟环境并安装依赖。
# 本环境没有 NVIDIA GPU，因此安装 CPU 版 PyTorch。
# torchmcubes 必须在已安装的 torch 上、关闭 build isolation 后编译。
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/TripoSR" && pwd)"
cd "$ROOT"

python3 -m venv .venv
.venv/bin/pip install -U pip setuptools wheel
.venv/bin/pip install torch --index-url https://download.pytorch.org/whl/cpu
grep -v 'tatsy/torchmcubes' requirements.txt | .venv/bin/pip install -r /dev/stdin
.venv/bin/pip install scikit-build-core ninja cmake pybind11 onnxruntime
.venv/bin/pip install --no-build-isolation "git+https://github.com/tatsy/torchmcubes.git"

echo
echo "安装完成。在 TripoSR 目录中运行示例："
echo "  .venv/bin/python run.py examples/chair.png --output-dir output/ --mc-resolution 128"
