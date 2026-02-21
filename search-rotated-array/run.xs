// Run job to test the search_rotated_array function
// Search in Rotated Sorted Array: Find target in a sorted array that was rotated at an unknown pivot
run.job "Test Search Rotated Array" {
  main = {
    name: "search_rotated_array"
    input: {
      nums: [4, 5, 6, 7, 0, 1, 2]
      target: 0
    }
  }
}
