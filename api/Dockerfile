# Use an official Python image
FROM python:3.10

# Set the working directory inside the container
WORKDIR /app

# Install Ollama and other dependencies
RUN curl -sSL https://ollama.com/install | bash

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application files
COPY . .

# Expose the FastAPI default port
EXPOSE 8000

# Run Ollama and FastAPI in the same container
CMD /bin/bash -c "ollama pull mistral && ollama run mistral && uvicorn api:app --host 0.0.0.0 --port 8000"
