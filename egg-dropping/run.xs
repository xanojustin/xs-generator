// Run job to test the egg_dropping function
// Egg Dropping: Find minimum attempts to find critical floor with k eggs and n floors
run.job "Test Egg Dropping" {
  main = {
    name: "egg_dropping"
    input: {
      k: 2
      n: 10
    }
  }
}
