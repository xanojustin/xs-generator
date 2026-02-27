// Run job to test the max_chunks function
run.job "Test Max Chunks To Sorted" {
  main = {
    name: "max_chunks"
    input: {
      arr: [1, 0, 2, 3, 4]
    }
  }
}
