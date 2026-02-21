// Run job to test the find_minimum_rotated function
// Find Minimum in Rotated Sorted Array
// Tests various rotated array configurations
run.job "Test Find Minimum Rotated" {
  main = {
    name: "find_minimum_rotated"
    input: {
      nums: [3, 4, 5, 1, 2]
    }
  }
}
