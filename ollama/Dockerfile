# Use Ollama base image
FROM ollama/ollama

# Set working directory to root (optional, or you can use /root as well)
WORKDIR /

# Copy requirements.txt from the root directory
COPY requirements.txt /requirements.txt

# Install dependencies
RUN apt-get update && apt-get install -y python3-pip && \
    pip3 install --no-cache-dir -r /requirements.txt

# Copy run_ollama.sh script from ollama folder to the root of the container
COPY run_ollama.sh /run_ollama.sh
RUN chmod +x /run_ollama.sh

# Expose Ollama API port
EXPOSE 11434

# Start Ollama + DeepSeek-R1
CMD ["/run_ollama.sh"]
