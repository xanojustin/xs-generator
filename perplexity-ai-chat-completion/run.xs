run.job "Perplexity AI Chat Completion" {
  main = {
    name: "perplexity_chat_completion"
    input: {
      model: "sonar"
      prompt: "What are the latest developments in artificial intelligence?"
      include_citations: true
    }
  }
  env = ["perplexity_api_key"]
}
