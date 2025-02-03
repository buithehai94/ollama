#!/bin/bash

# Start Ollama in the background
ollama serve --host 0.0.0.0 &

# Wait for Ollama to be available
until curl -s http://127.0.0.1:11434/api/tags > /dev/null; do
  echo "Waiting for Ollama to start..."
  sleep 2
done

echo "Ollama is running. Pulling DeepSeek-R1 model..."

# Pull the DeepSeek-R1 model
ollama pull deepseek-r1:1.5b

echo "DeepSeek-R1 model pulled successfully."

# Keep the container running
tail -f /dev/null
