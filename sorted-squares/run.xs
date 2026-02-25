// Run job to test the sorted_squares function
// Sorted Squares: Square a sorted array and return sorted result
run.job "Test Sorted Squares" {
  main = {
    name: "sorted_squares"
    input: {
      nums: [-4, -1, 0, 3, 10]
    }
  }
}
