# Use an official Python image
FROM python:3.10

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y curl

# Copy Ollama installation script from local machine to container
COPY ollama_install.sh /tmp/ollama_install.sh

# Run the script inside the container
RUN bash /tmp/ollama_install.sh

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application files
COPY . .

# Expose the FastAPI default port
EXPOSE 8000

# Run FastAPI with Uvicorn
CMD uvicorn api:app --host 0.0.0.0 --port 8000
