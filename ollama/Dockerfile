# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set the working directory
WORKDIR /app

# Install dependencies
RUN apt update && apt install -y curl python3 python3-pip

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | bash && \
    echo 'export PATH=$PATH:/root/.ollama/bin' >> ~/.bashrc

# Ensure Ollama is in PATH
ENV PATH="/root/.ollama/bin:${PATH}"

# Copy requirements if needed
COPY ../requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Expose the Ollama API port
EXPOSE 11434

# Start Ollama
CMD ["bash", "-c", "source ~/.bashrc && ollama serve"]
