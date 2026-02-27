// Run job to test the heaters function
run.job "Test Heaters" {
  main = {
    name: "heaters"
    input: {
      houses: [1, 2, 3],
      heaters: [2]
    }
  }
}
