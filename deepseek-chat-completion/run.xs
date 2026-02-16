run.job "DeepSeek Chat Completion" {
  main = {
    name: "deepseek_chat_completion"
    input: {
      model: "deepseek-chat"
      message: "Explain what XanoScript is in one sentence."
      temperature: 0.7
      max_tokens: 100
    }
  }
  env = ["deepseek_api_key"]
}
