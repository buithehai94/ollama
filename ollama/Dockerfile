# Use Ollama base image
FROM ollama/ollama

# Set working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt /app/requirements.txt

# Install dependencies
RUN apt-get update && apt-get install -y python3-pip && \
    pip3 install --no-cache-dir -r /app/requirements.txt

# Copy startup script
COPY run_ollama.sh /tmp/run_ollama.sh
RUN chmod +x /tmp/run_ollama.sh

# Expose Ollama API port
EXPOSE 11434

# Start Ollama with DeepSeek-R1
ENTRYPOINT ["/tmp/run_ollama.sh"]
