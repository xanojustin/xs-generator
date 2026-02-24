// Counting Sort - Non-comparison based sorting algorithm
// Counts occurrences of each value, then reconstructs sorted array
// Time Complexity: O(n + k) where n is array length and k is range of values
function "counting_sort" {
  description = "Sorts an array of non-negative integers using counting sort algorithm"
  
  input {
    int[] arr { description = "Array of non-negative integers to sort" }
  }
  
  stack {
    // Handle empty array
    conditional {
      if (`$input.arr|count == 0`) {
        return { value = [] }
      }
    }
    
    // Find the maximum value to determine count array size
    var $max_val { value = 0 }
    foreach ($input.arr) {
      each as $num {
        conditional {
          if ($num > $max_val) {
            var.update $max_val { value = $num }
          }
        }
      }
    }
    
    // Create count array initialized to zeros
    // Size is max_val + 1 to include index 0
    var $count_array { value = [] }
    var $j { value = 0 }
    while ($j <= $max_val) {
      each {
        var $count_array { 
          value = $count_array|merge:[0]
        }
        var.update $j { value = $j + 1 }
      }
    }
    
    // Count occurrences of each number
    foreach ($input.arr) {
      each as $num {
        var $current_count { 
          value = $count_array[$num]
        }
        var.update $count_array {
          value = $count_array|set:$num:($current_count + 1)
        }
      }
    }
    
    // Reconstruct sorted array
    var $sorted { value = [] }
    var $i { value = 0 }
    while ($i <= $max_val) {
      each {
        var $occurrences { value = $count_array[$i] }
        
        // Add the number $occurrences times to result
        while ($occurrences > 0) {
          each {
            var $sorted {
              value = $sorted|merge:[$i]
            }
            var.update $occurrences { value = $occurrences - 1 }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $sorted
}
