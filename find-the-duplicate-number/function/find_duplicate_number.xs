// Find the Duplicate Number - Classic coding exercise
// Given an array containing n+1 integers where each integer is between 1 and n (inclusive),
// prove that at least one duplicate number must exist. Assume there is only one duplicate number,
// find it without modifying the array and using only constant extra space.
// Uses Floyd's Cycle Detection (Tortoise and Hare) algorithm
function "find_duplicate_number" {
  description = "Finds the duplicate number in an array using Floyd's Cycle Detection algorithm"
  
  input {
    int[] nums { description = "Array of n+1 integers where each integer is between 1 and n" }
  }
  
  stack {
    // Initialize slow and fast pointers
    // We treat values as pointers (value at index i points to index nums[i])
    var $slow { value = $input.nums[0] }
    var $fast { value = $input.nums[0] }
    
    // Phase 1: Find the intersection point in the cycle
    // Move slow one step, fast two steps until they meet
    var $phase1_done { value = false }
    
    while (!$phase1_done) {
      each {
        // Slow moves one step: nums[slow]
        var $slow { value = $input.nums[$slow] }
        
        // Fast moves two steps: nums[nums[fast]]
        var $fast_step1 { value = $input.nums[$fast] }
        var $fast { value = $input.nums[$fast_step1] }
        
        conditional {
          if ($slow == $fast) {
            var $phase1_done { value = true }
          }
        }
      }
    }
    
    // Phase 2: Find the entrance to the cycle (the duplicate number)
    // Reset slow to start, keep fast at intersection
    // Move both one step at a time until they meet
    var $slow2 { value = $input.nums[0] }
    var $phase2_done { value = false }
    var $duplicate { value = 0 }
    
    while (!$phase2_done) {
      each {
        conditional {
          if ($slow2 == $fast) {
            var $duplicate { value = $slow2 }
            var $phase2_done { value = true }
          }
          else {
            // Both move one step
            var $slow2 { value = $input.nums[$slow2] }
            var $fast { value = $input.nums[$fast] }
          }
        }
      }
    }
  }
  
  response = $duplicate
}
