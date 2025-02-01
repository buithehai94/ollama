# Base image
FROM ubuntu:latest

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt update && apt install -y curl

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | bash

# Expose port
EXPOSE 11434

# Run Ollama
CMD ["ollama", "serve"]
