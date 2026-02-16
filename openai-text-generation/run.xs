run.job "OpenAI Text Generation" {
  main = {
    name: "openai_generate_text"
    input: {
      prompt: "Write a creative haiku about coding and coffee"
      model: "gpt-4o-mini"
      max_tokens: 150
      temperature: 0.7
    }
  }
  env = ["OPENAI_API_KEY"]
}