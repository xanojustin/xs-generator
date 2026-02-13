run.job "OpenAI Chat Completion" {
  main = {
    name: "chat_completion"
    input: {
      prompt: "Explain what XanoScript is in simple terms"
      model: "gpt-4o-mini"
      system_message: "You are a helpful assistant that explains technical concepts simply."
      temperature: "0.7"
      max_tokens: "500"
    }
  }
  env = ["OPENAI_API_KEY"]
}
