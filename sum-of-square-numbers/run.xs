// Run job to test sum of square numbers function
run.job "Test Sum of Square Numbers" {
  main = {
    name: "sum_of_square_numbers"
    input: {
      c: 5
    }
  }
}
