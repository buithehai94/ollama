import requests
from fastapi import FastAPI, Response, HTTPException

app = FastAPI()

@app.get('/')
def home():
    return {"Chat": "Bot"}

@app.get('/ask')
def ask(prompt: str):
    try:
        # Sending the prompt to the Ollama API
        res = requests.post('http://ollama:11434/api/generate', json={
            "prompt": prompt,
            "stream": False,
            "model": "llama3"
        })
        
        # Check if the request was successful
        res.raise_for_status()  # This will raise an exception for HTTP errors

        return Response(content=res.text, media_type="application/json")

    except requests.exceptions.RequestException as e:
        # Log the error (you can use a logging library here)
        print(f"Error communicating with Ollama API: {e}")
        raise HTTPException(status_code=500, detail="Failed to communicate with the Ollama API.")
