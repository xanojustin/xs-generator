run.job "Predict the Winner" {
  main = {
    name: "predict_the_winner"
    input: {
      nums: [1, 5, 2]
    }
  }
}
