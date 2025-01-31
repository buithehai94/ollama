# Use Python 3.11 slim image as the base image
FROM python:3.11-slim AS base

# Install necessary dependencies (build tools, PostgreSQL client, and curl)
RUN apt-get update -y && apt-get install -y \
    build-essential \
    libpq-dev \
    curl && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variable for the app directory
ENV APP_HOME=/api
WORKDIR $APP_HOME

# Copy the application files (the 'api' directory and other necessary files)
COPY ./api ./api
COPY ./requirements.txt ./
COPY ./api/ollama_install.sh ./  # Ensure script is copied correctly

# Ensure ollama_install.sh is executable and run it
RUN chmod +x ollama_install.sh && ./ollama_install.sh

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 8000 to be accessed from outside the container
EXPOSE 8000

# Run the FastAPI app with Uvicorn
CMD ["uvicorn", "api.api:app", "--host", "0.0.0.0", "--port", "8000"]
