# Use an official Python image
FROM python:3.10

# Set the working directory inside the container to /api
WORKDIR /api

# Install system dependencies (curl is required to install Ollama)
RUN apt-get update && apt-get install -y curl

# Copy Ollama installation script from the local api folder to the container
COPY api/ollama_install.sh /tmp/ollama_install.sh

# Run the script to install Ollama
RUN bash /tmp/ollama_install.sh

# Copy the requirements file from the root of your project to the container
COPY requirements.txt /api/

# Install Python dependencies
RUN pip install --no-cache-dir -r /api/requirements.txt

# Copy all files from the 'api' folder into the container's /api folder
COPY api /api

# Expose the FastAPI default port
EXPOSE 8000

# Command to run FastAPI with Uvicorn
CMD uvicorn api:app --host 0.0.0.0 --port 8000
