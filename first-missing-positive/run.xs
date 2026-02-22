run.job "First Missing Positive Test" {
  main = {
    name: "first_missing_positive"
    input: {
      nums: [3, 4, -1, 1]
    }
  }
}
