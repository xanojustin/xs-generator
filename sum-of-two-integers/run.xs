// Run job to test the sum_of_two_integers function
run.job "Test Sum of Two Integers" {
  main = {
    name: "sum_of_two_integers"
    input: {
      a: 5
      b: 7
    }
  }
}
