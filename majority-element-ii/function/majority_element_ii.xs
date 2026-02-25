// Majority Element II - Find all elements appearing more than n/3 times
// Uses Boyer-Moore Voting Algorithm for O(n) time and O(1) space
function "majority_element_ii" {
  description = "Finds all elements that appear more than n/3 times in the array"
  
  input {
    int[] nums { description = "Array of integers to analyze" }
  }
  
  stack {
    // Handle edge case of empty array
    conditional {
      if (($input.nums|count) == 0) {
        return { value = [] }
      }
    }
    
    // Boyer-Moore Voting Algorithm
    // There can be at most 2 elements with count > n/3
    var $candidate1 { value = null }
    var $candidate2 { value = null }
    var $count1 { value = 0 }
    var $count2 { value = 0 }
    
    // First pass: Find potential candidates
    foreach ($input.nums) {
      each as $num {
        conditional {
          if ($count1 > 0 && $num == $candidate1) {
            var.update $count1 { value = $count1 + 1 }
          }
          elseif ($count2 > 0 && $num == $candidate2) {
            var.update $count2 { value = $count2 + 1 }
          }
          elseif ($count1 == 0) {
            var $candidate1 { value = $num }
            var $count1 { value = 1 }
          }
          elseif ($count2 == 0) {
            var $candidate2 { value = $num }
            var $count2 { value = 1 }
          }
          else {
            var.update $count1 { value = $count1 - 1 }
            var.update $count2 { value = $count2 - 1 }
          }
        }
      }
    }
    
    // Second pass: Verify candidates
    var $count1_verify { value = 0 }
    var $count2_verify { value = 0 }
    var $n { value = $input.nums|count }
    var $threshold { value = $n / 3 }
    
    foreach ($input.nums) {
      each as $num {
        conditional {
          if ($count1 > 0 && $num == $candidate1) {
            var.update $count1_verify { value = $count1_verify + 1 }
          }
          elseif ($count2 > 0 && $num == $candidate2) {
            var.update $count2_verify { value = $count2_verify + 1 }
          }
        }
      }
    }
    
    // Build result with verified candidates
    var $result { value = [] }
    
    conditional {
      if ($count1_verify > $threshold) {
        var $result { value = $result|merge:[$candidate1] }
      }
    }
    
    conditional {
      if ($count2_verify > $threshold) {
        var $result { value = $result|merge:[$candidate2] }
      }
    }
  }
  
  response = $result
}
