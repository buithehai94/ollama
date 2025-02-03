#!/bin/bash

# Make sure `/data/db` directory exists even with persistent storage
mkdir -p /data/db
# If app crashed, mongo didn't stop gracefully. Remove all the old *.lock files
find /data/db -name "*.lock" -type f -exec rm -f {} \; 
# Start the local Mongo database
mongod &

# Start the text-generation-inference process
text-generation-launcher --model-id ${MODEL_NAME} --num-shard 1 --port 8080 --trust-remote-code &

# Wait for text-generation-inference to start
curl --retry 60 --retry-delay 10 --retry-connrefused http://127.0.0.1:8080/health

# Start the chat-ui process
dotenv -e /app/.env -c -- node /app/build/index.js -- --host 0.0.0.0 --port 3000
# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?
