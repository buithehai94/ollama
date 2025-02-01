# Use Ubuntu as the base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Install dependencies
RUN apt update && apt install -y curl python3 python3-pip

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | bash

# Copy and install Python dependencies (if needed)
COPY ../requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Expose Ollama's default API port
EXPOSE 11434

# Start Ollama
CMD ["ollama", "serve"]
