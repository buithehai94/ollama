import requests
from fastapi import FastAPI, Response, HTTPException
import logging
import os

# Setup logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Fetch Ollama API URL from environment variables (use default if not set)
OLLAMA_API_URL = os.getenv("OLLAMA_API_URL", "http://ollama:11434/api/generate")

app = FastAPI()

@app.get('/')
def home():
    return {"Chat": "Bot"}

@app.get('/ask')
def ask(prompt: str):
    if not prompt:
        raise HTTPException(status_code=400, detail="Prompt cannot be empty.")
        
    try:
        # Make a POST request to Ollama API
        res = requests.post(OLLAMA_API_URL, json={
            "prompt": prompt,
            "stream": False,
            "model": "llama3"
        }, timeout=10)  # Timeout set to 10 seconds
        
        res.raise_for_status()  # Raises exception for HTTP error responses (4xx, 5xx)

        return Response(content=res.text, media_type="application/json", status_code=res.status_code)

    except requests.exceptions.Timeout:
        logger.error("Request to Ollama API timed out.")
        raise HTTPException(status_code=504, detail="Request to Ollama API timed out.")
    
    except requests.exceptions.RequestException as e:
        logger.error(f"Error communicating with Ollama API: {e}")
        raise HTTPException(status_code=500, detail="Failed to communicate with the Ollama API.")
