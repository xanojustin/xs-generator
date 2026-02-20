// Run job to test the sum_of_multiples function
run.job "Test Sum of Multiples" {
  main = {
    name: "sum_of_multiples"
    input: {
      limit: 10
    }
  }
}
