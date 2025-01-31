FROM python:3.11-slim AS base

# Install necessary dependencies
RUN apt-get update -y && apt-get install -y \
    build-essential \
    libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set environment variable for the app directory
ENV APP_HOME=/api
WORKDIR $APP_HOME

# Copy the application files (both the 'api' folder and other necessary files)
COPY ./api ./api
COPY ./requirements.txt ./

# Install Python dependencies from requirements.txt
RUN pip install -r requirements.txt

# Ensure uvicorn is available globally
RUN pip install uvicorn[standard]

# Run the app with Uvicorn
CMD ["uvicorn", "api.api:app", "--host", "0.0.0.0", "--port", "8000"]
