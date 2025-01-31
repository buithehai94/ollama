# Use an official base image
FROM ubuntu:22.04

# Install dependencies
RUN apt update && apt install -y curl

# Install Ollama
RUN curl -fsSL https://ollama.ai/install.sh | bash

# Expose the Ollama API port
EXPOSE 11434

# Start the Ollama server
CMD ["ollama", "serve"]
