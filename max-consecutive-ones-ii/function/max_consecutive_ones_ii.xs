// Max Consecutive Ones II - LeetCode 487
// Given a binary array, find the maximum number of consecutive 1s 
// if you can flip at most one 0 to 1
function "max_consecutive_ones_ii" {
  description = "Find max consecutive 1s with at most one 0 flip allowed"
  
  input {
    int[] nums { description = "Binary array containing 0s and 1s" }
  }
  
  stack {
    var $left { value = 0 }
    var $zeros_count { value = 0 }
    var $max_length { value = 0 }
    
    foreach ($input.nums) {
      each as $num {
        // If current element is 0, increment zero count
        conditional {
          if ($num == 0) {
            math.add $zeros_count { value = 1 }
          }
        }
        
        // Shrink window if we have more than 1 zero
        while ($zeros_count > 1) {
          each {
            // If the element at left is 0, decrement zero count
            conditional {
              if ($input.nums[$left] == 0) {
                math.sub $zeros_count { value = 1 }
              }
            }
            // Move left pointer
            math.add $left { value = 1 }
          }
        }
        
        // Calculate current window size
        var $window_size { value = $each.index - $left + 1 }
        
        // Update max length if current window is larger
        conditional {
          if ($window_size > $max_length) {
            var.update $max_length { value = $window_size }
          }
        }
      }
    }
  }
  
  response = $max_length
}
