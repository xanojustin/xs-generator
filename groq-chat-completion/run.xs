run.job "Groq Chat Completion" {
  main = {
    name: "groq_chat_completion"
    input: {
      model: "llama-3.3-70b-versatile",
      message: "Explain what makes Groq's inference engine so fast in one sentence.",
      temperature: 0.7,
      max_tokens: 256
    }
  }
  env = ["GROQ_API_KEY"]
}
