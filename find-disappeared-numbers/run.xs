// Run job to test the find_disappeared_numbers function
// Find All Numbers Disappeared in an Array: 
// Given an array of integers where 1 <= nums[i] <= n (n = array length),
// some elements appear twice and others appear once.
// Find all numbers in range [1, n] that do NOT appear in the array.
run.job "Test Find Disappeared Numbers" {
  main = {
    name: "find_disappeared_numbers"
    input: {
      nums: [4, 3, 2, 7, 8, 2, 3, 1]
    }
  }
}
