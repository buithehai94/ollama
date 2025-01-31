#!/bin/sh
# This script installs Ollama on Linux.
# It detects the current operating system architecture and installs the appropriate version of Ollama.

set -eu

red="$( (/usr/bin/tput bold || :; /usr/bin/tput setaf 1 || :) 2>&-)"
plain="$( (/usr/bin/tput sgr0 || :) 2>&-)"

status() { echo ">>> $*" >&2; }
error() { echo "${red}ERROR:${plain} $*"; exit 1; }
warning() { echo "${red}WARNING:${plain} $*"; }

TEMP_DIR=$(mktemp -d)
cleanup() { rm -rf $TEMP_DIR; }
trap cleanup EXIT

available() { command -v $1 >/dev/null; }
require() {
    local MISSING=''
    for TOOL in $*; do
        if ! available $TOOL; then
            MISSING="$MISSING $TOOL"
        fi
    done

    echo $MISSING
}

# Check for required tools
REQUIRED_TOOLS="curl tar file"
MISSING_TOOLS=$(require $REQUIRED_TOOLS)
if [ -n "$MISSING_TOOLS" ]; then
    error "Missing required tools:$MISSING_TOOLS. Please install them and try again."
fi

# Detect architecture
ARCH=$(uname -m)
case "$ARCH" in
    x86_64) ARCH="amd64" ;;
    aarch64) ARCH="arm64" ;;
    *) error "Unsupported architecture: $ARCH" ;;
esac

# Download and install Ollama
status "Downloading Ollama for $ARCH..."
OLLAMA_URL="https://ollama.com/download/ollama-$ARCH.tar.gz"
curl -L $OLLAMA_URL -o $TEMP_DIR/ollama.tar.gz

# Check if the downloaded file is a valid gzip file
if file $TEMP_DIR/ollama.tar.gz | grep -q 'gzip compressed data'; then
    status "Installing Ollama..."
    tar -xzf $TEMP_DIR/ollama.tar.gz -C /usr/local/bin || error "Failed to extract Ollama. The file might not be in gzip format."
else
    error "Downloaded file is not a valid gzip file."
fi

status "Ollama installation complete."
ollama --version
