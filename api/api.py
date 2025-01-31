from fastapi import FastAPI
import subprocess

app = FastAPI()

# URL for Ollama API (not needed in this case)
# OLLAMA_API_URL = "http://127.0.0.1:11434/v1/chat/completions"  

@app.get("/")
async def root():
    return {"message": "Hello, FastAPI with Ollama!"}

@app.get("/chat/")
async def chat(prompt: str):
    # Construct the command to run Ollama with the given prompt
    command = f"ollama run llama --text \"{prompt}\""

    try:
        # Run the Ollama command and capture the output
        result = subprocess.run(command, shell=True, capture_output=True, text=True)

        # Check if the command was successful
        if result.returncode == 0:
            # Return the response from Ollama (stdout contains the output)
            return {"response": result.stdout.strip()}
        else:
            return {"error": "Failed to generate response", "status_code": result.returncode, "stderr": result.stderr}
    except Exception as e:
        return {"error": str(e)}
