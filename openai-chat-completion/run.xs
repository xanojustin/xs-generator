run.job "OpenAI Chat Completion" {
  main = {
    name: "openai_chat_completion"
    input: {
      model: "gpt-4o"
      messages: [
        {
          role: "system"
          content: "You are a helpful assistant."
        }
        {
          role: "user"
          content: "Hello! Tell me a fun fact about programming."
        }
      ]
      temperature: 0.7
      max_tokens: 150
    }
  }
  env = ["OPENAI_API_KEY"]
}
