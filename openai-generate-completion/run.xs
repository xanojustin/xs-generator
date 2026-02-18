run.job "OpenAI Generate Completion" {
  main = {
    name: "generate_completion"
    input: {
      prompt: "Write a haiku about programming"
      model: "gpt-4o-mini"
      max_tokens: 150
      temperature: 0.7
    }
  }
  env = ["OPENAI_API_KEY"]
}
