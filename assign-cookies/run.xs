// Run job to test the assign_cookies function
run.job "Test Assign Cookies" {
  main = {
    name: "assign_cookies"
    input: {
      greed_factors: [1, 2, 3]
      cookie_sizes: [1, 1]
    }
  }
}
