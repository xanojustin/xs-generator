// Run job to test the kth-smallest-element function
run.job "Test Kth Smallest Element" {
  main = {
    name: "kth-smallest-element"
    input: {
      numbers: [3, 2, 1, 5, 6, 4]
      k: 2
    }
  }
}
