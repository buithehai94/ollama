# Use an Ubuntu base image
FROM ubuntu:22.04  

# Set environment variables to prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive  

# Install dependencies
RUN apt update && apt install -y curl  

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh  

# Download and preload the DeepSeek-R1 1.5B model
RUN ollama pull deepseek-r1:1.5b  

# Expose the port for API access
EXPOSE 11434  

# Copy files
COPY ollama/entrypoint.sh /entrypoint.sh
COPY requirements.txt /requirements.txt

# Set permissions for entrypoint script
RUN chmod +x /entrypoint.sh

# Install Python dependencies
RUN apt install -y python3 python3-pip
RUN pip install -r /requirements.txt

# Set the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
