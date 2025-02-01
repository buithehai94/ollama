# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set the working directory
WORKDIR /app

# Install necessary dependencies
RUN apt update && apt install -y curl python3 python3-pip

# Install Ollama
RUN curl https://ollama.ai/install.sh | sh
