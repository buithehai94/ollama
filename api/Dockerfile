# Use an official Python image
FROM python:3.10

# Install dependencies
RUN apt update && apt install -y curl

# Install Ollama
RUN curl -fsSL https://ollama.ai/install.sh | bash

# Set working directory to /app
WORKDIR /app

# Copy requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy entire API folder into /app/api
COPY api /app/api

# Expose API port
EXPOSE 8000

# Start Ollama server in the background and run FastAPI
CMD ollama serve & uvicorn api.api:app --host 0.0.0.0 --port 8000
