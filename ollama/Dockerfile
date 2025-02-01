# Use Python 3.11 slim image as the base image
FROM python:3.11-slim AS base

# Set environment variables
ENV APP_HOME=/app
WORKDIR $APP_HOME

# Install system dependencies
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    file \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy only requirements first to leverage Docker layer caching
COPY ./requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application files (ollama directory and scripts)
COPY ./ollama ./ollama
COPY ./ollama/ollama_install.sh ./

# Ensure ollama_install.sh is executable and run it
RUN chmod +x ollama_install.sh && ./ollama_install.sh

# Create a non-root user for security (optional)
RUN useradd -m appuser && chown -R appuser:appuser $APP_HOME
USER appuser

# Default command (modify as needed)
CMD ["python", "-m", "your_main_script"]
