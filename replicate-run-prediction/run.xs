run.job "Replicate Run Prediction" {
  main = {
    name: "run_prediction"
    input: {
      model: "black-forest-labs/flux-schnell"
      prompt: "a professional photograph of a golden retriever wearing sunglasses on a beach at sunset"
      webhook_url: ""
    }
  }
  env = ["REPLICATE_API_TOKEN"]
}
