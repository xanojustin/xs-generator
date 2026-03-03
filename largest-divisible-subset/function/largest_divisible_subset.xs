// Largest Divisible Subset
// Given a set of distinct positive integers, return the largest subset
// such that every pair of elements in the subset satisfies:
// - a % b == 0 OR b % a == 0 (one is divisible by the other)
function "largest_divisible_subset" {
  description = "Finds the largest divisible subset from a list of distinct positive integers"
  
  input {
    int[] nums { description = "Array of distinct positive integers" }
  }
  
  stack {
    // Handle edge cases
    conditional {
      if (($input.nums|count) == 0) {
        return {
          value = {
            subset: [],
            size: 0
          }
        }
      }
      elseif (($input.nums|count) == 1) {
        return {
          value = {
            subset: $input.nums,
            size: 1
          }
        }
      }
    }
    
    // Sort the array to ensure we process smaller numbers first
    var $sorted { value = $input.nums|sort }
    var $n { value = $input.nums|count }
    
    // dp[i] = size of largest divisible subset ending with sorted[i]
    var $dp { value = [] }
    var $parent { value = [] }
    
    // Initialize dp and parent arrays
    for ($n) {
      each as $i {
        var.update $dp { value = $dp|push:1 }
        var.update $parent { value = $parent|push:-1 }
      }
    }
    
    // Build dp array
    var $max_size { value = 1 }
    var $max_index { value = 0 }
    var $i { value = 1 }
    
    while ($i < $n) {
      each {
        var $j { value = 0 }
        var $best_parent { value = -1 }
        var $best_size { value = 0 }
        
        while ($j < $i) {
          each {
            // Check if sorted[i] is divisible by sorted[j]
            var $divisible { 
              value = ($sorted[$i] % $sorted[$j]) == 0
            }
            
            conditional {
              if ($divisible) {
                conditional {
                  if ($dp[$j] > $best_size) {
                    var $best_size { value = $dp[$j] }
                    var $best_parent { value = $j }
                  }
                }
              }
            }
            
            var.update $j { value = $j + 1 }
          }
        }
        
        conditional {
          if ($best_parent >= 0) {
            var $new_size { value = $best_size + 1 }
            var.update $dp {
              value = $dp|set:$i:$new_size
            }
            var.update $parent {
              value = $parent|set:$i:$best_parent
            }
            
            conditional {
              if ($new_size > $max_size) {
                var $max_size { value = $new_size }
                var $max_index { value = $i }
              }
            }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
    
    // Reconstruct the subset by backtracking through parent pointers
    var $subset { value = [] }
    var $curr { value = $max_index }
    
    while ($curr >= 0) {
      each {
        var.update $subset {
          value = $subset|push:($sorted[$curr])
        }
        var $curr {
          value = $parent[$curr]
        }
      }
    }
    
    // Reverse to get ascending order
    var $subset { value = $subset|reverse }
    
    return {
      value = {
        subset: $subset,
        size: $max_size
      }
    }
  }
  
  response = $result
}
