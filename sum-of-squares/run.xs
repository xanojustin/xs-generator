// Run job to test the sum_of_squares function
run.job "Test Sum of Squares" {
  main = {
    name: "sum_of_squares"
    input: {
      n: 10
    }
  }
}
