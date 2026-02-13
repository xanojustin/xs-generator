run.job "Anthropic Claude Completion" {
  main = {
    name: "claude_completion"
    input: {
      prompt: "Explain XanoScript in one sentence."
      model: "claude-3-5-sonnet-20241022"
      max_tokens: 500
      temperature: 0.7
      system_prompt: "You are a helpful, harmless, and honest AI assistant."
    }
  }
  env = ["anthropic_api_key"]
}
