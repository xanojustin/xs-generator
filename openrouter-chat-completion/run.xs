run.job "openrouter_chat_completion" {
  main = {
    name: "call_openrouter_chat"
    input: {
      model: "anthropic/claude-3.5-sonnet"
      message: "Hello, how are you?"
    }
  }
  env = ["OPENROUTER_API_KEY"]
}
