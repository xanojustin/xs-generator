// Run job to test the kth_largest_element function
run.job "Test Kth Largest Element" {
  main = {
    name: "kth_largest_element"
    input: {
      nums: [3, 2, 1, 5, 6, 4]
      k: 2
    }
  }
}
