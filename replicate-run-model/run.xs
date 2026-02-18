run.job "Replicate Run AI Model" {
  main = {
    name: "replicate_run_prediction"
    input: {
      model: "black-forest-labs/flux-schnell"
      input_data: {
        prompt: "A serene mountain landscape at sunset with a lake reflection"
        aspect_ratio: "16:9"
        output_format: "webp"
        output_quality: 80
      }
      wait_for_completion: true
      poll_interval: 1
      max_poll_attempts: 60
    }
  }
  env = ["REPLICATE_API_TOKEN"]
}
