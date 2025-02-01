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

# Copy the requirements.txt first to leverage Docker cache
COPY ./requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Ollama application files (ollama directory)
COPY ./ollama ./ollama

# Create a non-root user for security (optional)
RUN useradd -m appuser && chown -R appuser:appuser $APP_HOME
USER appuser

# Default command (can be adjusted to your needs)
# In this case, just launching a shell so you can interact with the container
CMD ["bash"]
