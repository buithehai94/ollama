# Use Ollama base image
FROM ollama/ollama

# Set working directory
WORKDIR /app

# Copy startup script
COPY run_ollama.sh /tmp/run_ollama.sh
RUN chmod +x /tmp/run_ollama.sh

# Expose Ollama API port
EXPOSE 11434

# Start Ollama with DeepSeek-R1
ENTRYPOINT ["/tmp/run_ollama.sh"]
