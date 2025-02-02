#!/bin/bash

echo "Pulling DeepSeek-R1 (1.5B) model..."
ollama pull deepseek-r1:1.5b

echo "Starting Ollama with DeepSeek-R1..."
ollama serve
