// Run job to test the Jump Game function
run.job "Test Jump Game" {
  main = {
    name: "jumpGame"
    input: {
      nums: [2, 3, 1, 1, 4]
    }
  }
}
