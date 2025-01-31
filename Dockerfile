# Use an official Python image
FROM python:3.10

# Install dependencies
RUN apt update && apt install -y curl

# Install Ollama
RUN curl -fsSL https://ollama.ai/install.sh | bash

# Install Python dependencies
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose API port
EXPOSE 8000

# Start Ollama server in the background and run FastAPI
CMD ollama serve & uvicorn api:app --host 0.0.0.0 --port 8000
