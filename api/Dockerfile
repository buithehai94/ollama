FROM python:3.11-slim AS base

# Build stage
FROM base AS builder
RUN apt-get update -y && apt-get install -y \
    build-essential \
    libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /api
COPY ./api ./api
COPY ./requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Production stage
FROM python:3.11-slim AS production
WORKDIR /api
COPY --from=builder /api /api
CMD exec uvicorn api.api:app --host '0.0.0.0' --port 5005
