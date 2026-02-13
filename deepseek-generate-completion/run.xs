run.job "DeepSeek Generate Completion" {
  main = {
    name: "generate_completion"
    input: {
      prompt: "Explain quantum computing in simple terms"
      model: "deepseek-chat"
      temperature: 0.7
      max_tokens: 1024
    }
  }
  env = ["deepseek_api_key"]
}
