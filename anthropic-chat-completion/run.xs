run.job "Anthropic Chat Completion" {
  main = {
    name: "chat_completion"
    input: {
      prompt: "Explain what XanoScript is in simple terms"
      model: "claude-3-5-sonnet-20241022"
      system_message: "You are a helpful assistant that explains technical concepts simply."
      max_tokens: "1000"
      temperature: "0.7"
    }
  }
  env = ["ANTHROPIC_API_KEY"]
}