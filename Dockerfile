FROM ghcr.io/huggingface/chat-ui:latest AS base

FROM ghcr.io/huggingface/text-generation-inference:latest AS final

ARG MODEL_NAME
ENV MODEL_NAME=${MODEL_NAME}

ENV TZ=Europe/Paris \
    PORT=3000

# mongo installation
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
    gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor

RUN echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    mongodb-org && \
    rm -rf /var/lib/apt/lists/*

# node installation
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | /bin/bash -

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    nodejs && \
    rm -rf /var/lib/apt/lists/*

# image setup
RUN useradd -m -u 1000 user

RUN mkdir /app
RUN chown -R 1000:1000 /app
RUN mkdir /data
RUN chown -R 1000:1000 /data

# Switch to the "user" user
USER user

ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

RUN npm config set prefix /home/user/.local
RUN npm install -g dotenv-cli


# copy chat-ui from base image
COPY --from=base --chown=1000 /app/node_modules /app/node_modules
COPY --from=base --chown=1000 /app/package.json /app/package.json
COPY --from=base --chown=1000 /app/build /app/build

COPY --from=base --chown=1000 /app/.env /app/.env
COPY --chown=1000 .env.local /app/.env.local

COPY --chown=1000 entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh

# entrypoint
ENTRYPOINT [ "/app/entrypoint.sh" ]
