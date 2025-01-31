from fastapi import FastAPI
import ollama

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Ollama API is running!"}

@app.post("/generate")
def generate(prompt: str):
    response = ollama.chat(model="mistral", messages=[{"role": "user", "content": prompt}])
    return {"response": response['message']}
