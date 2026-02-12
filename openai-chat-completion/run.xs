run.job "OpenAI Chat Completion" {
  main = {
    name: "openai_chat"
    input: {
      prompt: "Explain XanoScript in one sentence."
      model: "gpt-4o-mini"
      temperature: 0.7
      max_tokens: 150
    }
  }
  env = ["openai_api_key"]
}
