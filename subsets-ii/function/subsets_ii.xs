function "subsets_ii" {
  description = "Find all unique subsets of a list that may contain duplicate elements"
  input {
    int[] nums { description = "Array of integers (may contain duplicates)" }
  }
  stack {
    // Sort the input to group duplicates together
    var $sorted_nums {
      value = $input.nums|sort
    }
    
    // Result will store all unique subsets
    var $result {
      value = [[]]
    }
    
    // Helper function variables for backtracking
    var $n {
      value = $sorted_nums|count
    }
    
    // Current subset being built
    var $current {
      value = []
    }
    
    // Start the backtracking from index 0
    var $start_idx {
      value = 0
    }
    
    // Use a recursive approach with stack-based iteration
    // We'll use a manual stack to simulate recursion
    var $stack {
      value = [{ idx: 0, current: [] }]
    }
    
    // Alternative approach: iterative with duplicate skipping
    // Process each element and decide to include or exclude
    var $i {
      value = 0
    }
    
    while ($i < $n) {
      each {
        // Get current element
        var $num {
          value = $sorted_nums[$i]
        }
        
        // Count how many times this element appears consecutively
        var $count {
          value = 1
        }
        
        var $j {
          value = $i + 1
        }
        
        while ($j < $n && $sorted_nums[$j] == $num) {
          each {
            var.update $count { value = $count + 1 }
            var.update $j { value = $j + 1 }
          }
        }
        
        // Get current size of result (subsets without this number)
        var $current_size {
          value = $result|count
        }
        
        // For each existing subset, create new subsets by adding
        // 1 to $count copies of $num
        var $k {
          value = 0
        }
        
        while ($k < $current_size) {
          each {
            var $existing_subset {
              value = $result[$k]
            }
            
            // Add 1, 2, ..., up to $count copies of num
            var $copy_count {
              value = 1
            }
            
            while ($copy_count <= $count) {
              each {
                // Create new subset with copy_count copies of num
                var $new_subset {
                  value = $existing_subset
                }
                
                // Add the number copy_count times
                var $m {
                  value = 0
                }
                
                while ($m < $copy_count) {
                  each {
                    var $new_subset_array {
                      value = $new_subset
                    }
                    var.update $new_subset_array { value = $new_subset_array|push:$num }
                    var.update $new_subset { value = $new_subset_array }
                    var.update $m { value = $m + 1 }
                  }
                }
                
                // Add to result
                var $result_array {
                  value = $result
                }
                var.update $result_array { value = $result_array|push:$new_subset }
                var.update $result { value = $result_array }
                
                var.update $copy_count { value = $copy_count + 1 }
              }
            }
            
            var.update $k { value = $k + 1 }
          }
        }
        
        // Move to next unique element
        var.update $i { value = $j }
      }
    }
  }
  response = $result
}
