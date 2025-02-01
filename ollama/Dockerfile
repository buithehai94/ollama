# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set the working directory
WORKDIR /app

# Install necessary dependencies
RUN apt update && apt install -y curl python3 python3-pip

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | bash

# Manually add Ollama binary to the PATH environment variable
ENV PATH="/root/.ollama/bin:$PATH"

# Make sure the Ollama binary is executable
RUN chmod +x /root/.ollama/bin/ollama

# Copy your requirements.txt and install dependencies (if needed)
COPY ../requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Expose the Ollama API port
EXPOSE 11434

# Start Ollama (with absolute path to Ollama)
CMD ["/root/.ollama/bin/ollama", "serve"]
