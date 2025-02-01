# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set the working directory
WORKDIR /app

# Install necessary dependencies
RUN apt update && \
    apt install -y curl python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -fsSL https://ollama.ai/install.sh | sh

# Ensure the Ollama binary is executable
RUN chmod 755 /root/.ollama/bin/ollama && \
    chown root:root /root/.ollama/bin/ollama

# Set the PATH to include Ollama binary location
ENV PATH="/root/.ollama/bin:$PATH"

# Expose the Ollama API port (or the port your app is listening on)
EXPOSE 11434

# Start Ollama (with the full path to the binary)
CMD ["/root/.ollama/bin/ollama", "serve"]
