#!/bin/bash
# wait-for-it.sh
# This script waits for a service to be ready before proceeding.

host="$1"
shift
port="$1"
shift
timeout=30  # Timeout in seconds

# Wait until the service is ready
until nc -z -v -w30 $host $port
do
  echo "Waiting for $host:$port to be available..."
  sleep 1
done

# Execute the command passed to the script
exec "$@"
