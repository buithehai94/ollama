# Use Python 3.11 slim image as the base image
FROM python:3.11-slim AS base

# Install necessary dependencies (build tools, curl, and file)
RUN apt-get update -y && apt-get install -y \
    build-essential \
    curl \
    file \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set environment variable for the app directory
ENV APP_HOME=/app
WORKDIR $APP_HOME

# Copy the application files (the 'api' directory and other necessary files)
COPY ./api ./api   

# Copy the install script from the api folder
COPY ./api/ollama_install.sh ./ 

# Copy requirements.txt from the root folder (since it's outside the 'api' folder)
COPY ./requirements.txt ./requirements.txt

# Ensure ollama_install.sh is executable and run it
RUN chmod +x ./ollama_install.sh && ./ollama_install.sh

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r ./requirements.txt

# Expose the port the app runs on
EXPOSE 8000

# Run the application
CMD ["uvicorn", "api.api:app", "--host", "0.0.0.0", "--port", "8000"]
