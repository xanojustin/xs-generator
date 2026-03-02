// Run job to test the sort_by_parity_ii function
run.job "Test Sort By Parity II" {
  main = {
    name: "sort_by_parity_ii"
    input: {
      nums: [4, 2, 5, 7]
    }
  }
}
