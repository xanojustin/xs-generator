// Run job to test the binary_search function
// Binary Search: Find the index of a target value in a sorted array
run.job "Test Binary Search" {
  main = {
    name: "binary_search"
    input: {
      nums: [1, 3, 5, 7, 9, 11, 13, 15, 17, 19]
      target: 13
    }
  }
}
