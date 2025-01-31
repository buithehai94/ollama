# Use an official Python image
FROM python:3.10

# Set the working directory inside the container
WORKDIR /api

# Install system dependencies (curl is required to install Ollama)
RUN apt-get update && apt-get install -y curl

# Copy the requirements file to the container
COPY requirements.txt /api/

# Install Python dependencies
RUN pip install --no-cache-dir -r /api/requirements.txt

# Copy the locally downloaded Ollama tar file into the container (if you manually downloaded it)
COPY ./ollama-install.tar.gz /tmp/ollama-install.tar.gz

# Extract the tar file to install Ollama
RUN tar -xzvf /tmp/ollama-install.tar.gz -C /usr/local/

# Copy the rest of the application files into the container
COPY api /api

# Expose the FastAPI default port
EXPOSE 8000

# Command to run FastAPI with Uvicorn
CMD uvicorn api:app --host 0.0.0.0 --port 8000
