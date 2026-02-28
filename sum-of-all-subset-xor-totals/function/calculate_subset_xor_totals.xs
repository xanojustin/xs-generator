function "calculate_subset_xor_totals" {
  description = "Calculate the sum of XOR of all possible subsets"
  input {
    int[] nums
  }
  stack {
    // Use iterative approach to generate all subset XOR values
    // Start with 0 (empty subset XOR)
    
    var $subset_xors {
      value = [0]
    }
    
    // Iterate through each number in the array
    foreach ($input.nums) {
      each as $num {
        // For each existing subset XOR value, create a new subset
        // by XORing with current number
        var $current_xors {
          value = $subset_xors
        }
        
        foreach ($current_xors) {
          each as $xor_val {
            // Create new subset XOR by XORing with current num
            var $new_xor {
              value = $xor_val|bitwise_xor:$num
            }
            // Add to our list of subset XORs using push filter
            var $subset_xors {
              value = $subset_xors|push:$new_xor
            }
          }
        }
      }
    }
    
    // Sum all XOR values using the sum filter
    var $total_sum {
      value = $subset_xors|sum
    }
  }
  response = $total_sum
}
