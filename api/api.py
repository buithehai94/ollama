import requests
from fastapi import FastAPI, Response, HTTPException
import logging

# Setup logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI()

@app.get('/')
def home():
    return {"Chat": "Bot"}

@app.get('/ask')
def ask(prompt: str):
    if not prompt:
        raise HTTPException(status_code=400, detail="Prompt cannot be empty.")
        
    try:
        res = requests.post('http://ollama:11434/api/generate', json={
            "prompt": prompt,
            "stream": False,
            "model": "llama3"
        }, timeout=10)  # Timeout set to 10 seconds
        
        res.raise_for_status()  # This will raise an exception for HTTP errors

        return Response(content=res.text, media_type="application/json", status_code=res.status_code)

    except requests.exceptions.RequestException as e:
        logger.error(f"Error communicating with Ollama API: {e}")
        raise HTTPException(status_code=500, detail="Failed to communicate with the Ollama API.")
