run.job "Anthropic Chat Completion" {
  main = {
    name: "anthropic_chat"
    input: {
      model: "claude-3-5-sonnet-20241022"
      max_tokens: 1024
      messages: [
        {role: "user", content: "Hello, Claude! Can you explain what XanoScript is in one sentence?"}
      ]
    }
  }
  env = ["anthropic_api_key"]
}
