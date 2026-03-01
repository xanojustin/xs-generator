// Sum of Even Numbers After Queries
// Given an integer array nums and a 2D array queries where queries[i] = [vali, indexi],
// for each query, add vali to nums[indexi], then return the sum of even numbers in nums.
function "sum_evens_after_queries" {
  description = "Returns the sum of even numbers after each query is applied"
  
  input {
    int[] nums
    object[] queries {
      schema {
        int val
        int index
      }
    }
  }
  
  stack {
    // Create a copy of nums that we can modify
    var $current_nums {
      value = $input.nums
    }
    
    // Initialize result array
    var $result {
      value = []
    }
    
    // Process each query
    foreach ($input.queries) {
      each as $query {
        // Get the current value at the index
        var $current_value {
          value = $current_nums[$query.index]
        }
        
        // Calculate new value
        var $new_value {
          value = $current_value + $query.val
        }
        
        // Update the array at the index
        var.update $current_nums[$query.index] {
          value = $new_value
        }
        
        // Calculate sum of even numbers
        var $even_sum {
          value = 0
        }
        
        foreach ($current_nums) {
          each as $num {
            conditional {
              if ($num % 2 == 0) {
                math.add $even_sum {
                  value = $num
                }
              }
            }
          }
        }
        
        // Append the sum to result
        var.update $result {
          value = $result|merge:[$even_sum]
        }
      }
    }
  }
  
  response = $result
}
