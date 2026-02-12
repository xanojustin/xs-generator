run.job "OpenAI Content Moderation" {
  main = {
    name: "moderate_content"
    input: {
      text: "Sample text to check for harmful content"
      model: "omni-moderation-latest"
    }
  }
  env = ["openai_api_key"]
}
