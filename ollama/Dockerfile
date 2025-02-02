# Use Ollama base image
FROM ollama/ollama

# Set working directory
WORKDIR /app

# Copy requirements.txt from the root directory
COPY requirements.txt /app/requirements.txt

# Install dependencies
RUN apt-get update && apt-get install -y python3-pip && \
    pip3 install --no-cache-dir -r /app/requirements.txt

# Copy startup script to working directory (no need for /tmp)
COPY ollama/run_ollama.sh /app/run_ollama.sh
RUN chmod +x /app/run_ollama.sh

# Expose Ollama API port
EXPOSE 11434

# Start Ollama + DeepSeek-R1
CMD ["/app/run_ollama.sh"]
