from fastapi import FastAPI
import httpx

app = FastAPI()

OLLAMA_API_URL = "http://127.0.0.1:11434/v1/chat/completions"  # URL for Ollama API

@app.get("/")
async def root():
    return {"message": "Hello, FastAPI with Ollama!"}

@app.get("/chat/")
async def chat(prompt: str):
    # Create the payload for the chat request
    payload = {
        "model": "mistral",
        "messages": [{"role": "user", "content": prompt}]
    }

    async with httpx.AsyncClient() as client:
        # Send request to Ollama API
        response = await client.post(OLLAMA_API_URL, json=payload)

        if response.status_code == 200:
            return response.json()  # Return the chat response
        else:
            return {"error": "Failed to generate response", "status_code": response.status_code}
