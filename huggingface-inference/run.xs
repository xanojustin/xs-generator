run.job "Hugging Face Inference" {
  main = {
    name: "run_inference"
    input: {
      model: "facebook/bart-large-mnli"
      text: "I love using XanoScript for building backend applications!"
      candidate_labels: ["technology", "sports", "food", "politics"]
      wait_for_model: true
    }
  }
  env = ["HUGGINGFACE_API_KEY"]
}
