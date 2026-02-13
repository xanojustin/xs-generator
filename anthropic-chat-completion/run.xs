run.job "Anthropic Claude Chat Completion" {
  main = {
    name: "anthropic_chat_completion"
    input: {
      model: "claude-3-sonnet-20240229"
      system: "You are Claude, a helpful AI assistant created by Anthropic."
      messages: [
        {
          role: "user"
          content: "Hello! Tell me a fun fact about artificial intelligence."
        }
      ]
      temperature: 0.7
      max_tokens: 1024
    }
  }
  env = ["ANTHROPIC_API_KEY"]
}
