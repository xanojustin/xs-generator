run.job "Groq Chat Completion" {
  main = {
    name: "groq_chat_completion"
    input: {
      model: "llama-3.3-70b-versatile"
      message: "Explain the benefits of fast AI inference in one sentence."
    }
  }
  env = ["groq_api_key"]
}
