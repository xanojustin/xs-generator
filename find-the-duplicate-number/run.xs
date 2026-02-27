// Run job to test the find_duplicate_number function
// Find the Duplicate Number: Uses Floyd's Cycle Detection to find duplicate without
// modifying the array and using only O(1) extra space
run.job "Test Find Duplicate Number" {
  main = {
    name: "find_duplicate_number"
    input: {
      nums: [1, 3, 4, 2, 2]
    }
  }
}
