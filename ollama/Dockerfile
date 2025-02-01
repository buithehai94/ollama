# Use a base image that supports CUDA and Python
FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu22.04

# Set the working directory
WORKDIR /ollama

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    python3 \
    python3-pip \
    python3-setuptools \
    && rm -rf /var/lib/apt/lists/*

# Install vLLM using pip
RUN pip install --no-cache-dir vllm

# Expose the port the app will run on
EXPOSE 8000

# Command to serve the model using vLLM
CMD ["vllm", "serve", "deepseek-ai/DeepSeek-R1"]
