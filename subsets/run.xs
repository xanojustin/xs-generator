// Run job to test the subsets function
run.job "Test Subsets" {
  main = {
    name: "subsets"
    input: {
      nums: [1, 2, 3]
    }
  }
}
