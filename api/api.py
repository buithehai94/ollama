import requests
from fastapi import FastAPI, HTTPException
import logging
import os

# Setup logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Fetch Ollama API URL from environment variables
OLLAMA_API_URL = os.getenv("OLLAMA_API_URL", "http://ollama:11434/api/generate")

app = FastAPI()

@app.get('/')
def home():
    return {"Chat": "Bot"}

@app.get('/ask')
def ask(prompt: str, model: str = "llama3"):
    if not prompt:
        raise HTTPException(status_code=400, detail="Prompt cannot be empty.")
        
    try:
        # Make a POST request to Ollama API
        res = requests.post(OLLAMA_API_URL, json={
            "model": model,
            "prompt": prompt
        })
        res.raise_for_status()

        # Try parsing JSON, fallback to raw text
        try:
            return res.json()
        except ValueError:
            return {"error": "Invalid response from Ollama", "details": res.text}

    except requests.RequestException as e:
        logger.error(f"Error communicating with Ollama API: {e}")
        raise HTTPException(status_code=500, detail="Error communicating with Ollama API")
