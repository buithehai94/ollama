# Use an official Python image
FROM python:3.10

# Set the working directory inside the container to /api
WORKDIR /api

# Install system dependencies (curl is required to install Ollama)
RUN apt-get update && apt-get install -y curl

# Copy Ollama installation script from the local machine to the container
COPY ollama_install.sh /tmp/ollama_install.sh

# Run the script to install Ollama
RUN bash /tmp/ollama_install.sh

# Copy requirements file to the container and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all files from the 'api' folder into the container's /api folder
COPY . .

# Expose the FastAPI default port
EXPOSE 8000

# Command to run FastAPI with Uvicorn
CMD uvicorn api:app --host 0.0.0.0 --port 8000
