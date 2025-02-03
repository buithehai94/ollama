#!/bin/bash

# Start Ollama in the background and bind to all interfaces (0.0.0.0) on port 11434
ollama serve --host 0.0.0.0 --port 11434 &

# Wait until the Ollama API is available on port 11434
echo "Waiting for Ollama to start on port 11434..."
until curl -s http://127.0.0.1:11434/api/tags > /dev/null; do
  sleep 2
done

echo "Ollama is running. Pulling DeepSeek-R1 model..."

# Pull the DeepSeek-R1 model
ollama pull deepseek-r1:1.5b

echo "DeepSeek-R1 model pulled successfully."

# Keep the container running
tail -f /dev/null
