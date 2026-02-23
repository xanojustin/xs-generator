function "is_symmetric" {
  description = "Check if a binary tree is symmetric around its center"
  input {
    int[] tree { description = "Array representation of binary tree where index i has children at 2i+1 and 2i+2" }
  }
  stack {
    // Helper function to check if two subtrees are mirrors
    // We'll use a recursive approach with indices
    
    // Handle empty tree
    conditional {
      if (($input.tree|count) == 0) {
        var $result { value = true }
      }
    }
    
    // Recursive helper to check symmetry between two positions
    // left_idx and right_idx are the root positions of the subtrees to compare
    var $is_mirror {
      value = true
    }
    
    // Use a manual stack approach with arrays to simulate recursion
    // Each entry will be [left_idx, right_idx] pairs to compare
    var $stack {
      value = [[0, 0]]
    }
    
    while (($stack|count) > 0) {
      each {
        // Pop the top pair
        var $pair { value = ($stack|first) }
        var.update $stack { value = $stack|slice:1:($stack|count) }
        
        var $left_idx { value = ($pair|first) }
        var $right_arr { value = $pair|slice:1:2 }
        var $right_idx { value = ($right_arr|first) }
        
        // Get values at these indices (null if out of bounds)
        var $left_val {
          value = ($left_idx < ($input.tree|count)) ? $input.tree[$left_idx] : null
        }
        var $right_val {
          value = ($right_idx < ($input.tree|count)) ? $input.tree[$right_idx] : null
        }
        
        // Check if both are null - this is symmetric
        conditional {
          if (($left_val == null) && ($right_val == null)) {
            // Both null, symmetric - continue to next iteration
          }
          elseif (($left_val == null) || ($right_val == null)) {
            // One is null, one is not - not symmetric
            var.update $is_mirror { value = false }
            // Clear stack to exit loop
            var.update $stack { value = [] }
          }
          elseif ($left_val != $right_val) {
            // Values don't match - not symmetric
            var.update $is_mirror { value = false }
            // Clear stack to exit loop
            var.update $stack { value = [] }
          }
          else {
            // Values match, check children
            // For a mirror: left's left should match right's right
            // and left's right should match right's left
            var $left_left { value = (2 * $left_idx) + 1 }
            var $left_right { value = (2 * $left_idx) + 2 }
            var $right_left { value = (2 * $right_idx) + 1 }
            var $right_right { value = (2 * $right_idx) + 2 }
            
            // Add pairs to check: (left_left, right_right) and (left_right, right_left)
            // But only if at least one of each pair exists
            var $ll_val { value = ($left_left < ($input.tree|count)) ? $input.tree[$left_left] : null }
            var $rr_val { value = ($right_right < ($input.tree|count)) ? $input.tree[$right_right] : null }
            var $lr_val { value = ($left_right < ($input.tree|count)) ? $input.tree[$left_right] : null }
            var $rl_val { value = ($right_left < ($input.tree|count)) ? $input.tree[$right_left] : null }
            
            // Only push if at least one of the pair has a value
            conditional {
              if (($ll_val != null) || ($rr_val != null)) {
                var $new_pair1 { value = [$left_left, $right_right] }
                var.update $stack { value = $stack ~ [$new_pair1] }
              }
            }
            
            conditional {
              if (($lr_val != null) || ($rl_val != null)) {
                var $new_pair2 { value = [$left_right, $right_left] }
                var.update $stack { value = $stack ~ [$new_pair2] }
              }
            }
          }
        }
      }
    }
    
    var $result { value = $is_mirror }
  }
  response = $result
}
