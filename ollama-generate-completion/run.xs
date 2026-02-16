run.job "Ollama Generate Completion" {
  main = {
    name: "ollama_generate"
    input: {
      model: "llama3.2"
      prompt: "What is the capital of France?"
      stream: false
    }
  }
  env = ["OLLAMA_BASE_URL"]
}
