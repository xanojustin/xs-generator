// Run job to test the number_of_good_pairs function
run.job "Test Number of Good Pairs" {
  main = {
    name: "number_of_good_pairs"
    input: {
      nums: [1, 2, 3, 1, 1, 3]
    }
  }
}
