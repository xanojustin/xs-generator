// Run job to test the dominant_index function
run.job "Test Dominant Index" {
  main = {
    name: "dominant_index"
    input: {
      nums: [3, 6, 1, 0]
    }
  }
}
