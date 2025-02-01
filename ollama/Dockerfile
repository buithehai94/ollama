# Use a base image with Python (CPU version)
FROM python:3.8-slim

# Set the working directory
WORKDIR /ollama

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    python3-setuptools \
    && rm -rf /var/lib/apt/lists/*

# Install vLLM using pip
RUN pip install --no-cache-dir vllm

# Verify vLLM installation
RUN python3 -m pip show vllm

# Expose the port the app will run on
EXPOSE 8000

# Command to serve the model using vLLM
CMD ["vllm", "serve", "deepseek-ai/DeepSeek-R1"]
