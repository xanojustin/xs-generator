// Minimum Absolute Difference in BST
// Given the root of a Binary Search Tree (BST), return the minimum absolute
// difference between the values of any two different nodes in the tree.
function "minimum_absolute_difference_in_bst" {
  description = "Finds the minimum absolute difference between any two nodes in a BST"
  
  input {
    object root {
      description = "Root node of the BST with val, left, and right properties"
    }
  }
  
  stack {
    // Collect all node values using in-order traversal
    var $values { value = [] }
    
    // Helper function simulation using a stack for iterative in-order traversal
    var $stack { value = [] }
    var $current { value = $input.root }
    
    // Iterative in-order traversal
    while ($current != null || ($stack|count) > 0) {
      each {
        // Go to leftmost node
        while ($current != null) {
          each {
            var $stack { value = $stack|merge:[$current] }
            var $current { value = $current|get:"left" }
          }
        }
        
        // Process current node
        conditional {
          if (($stack|count) > 0) {
            // Pop from stack
            var $current { value = $stack|last }
            var $stack { value = $stack|slice:0:(-1) }
            
            // Add value to values array
            var $node_val { value = $current|get:"val" }
            var $values { value = $values|merge:[$node_val] }
            
            // Move to right subtree
            var $current { value = $current|get:"right" }
          }
        }
      }
    }
    
    // Find minimum absolute difference between adjacent values
    // Using a large initial value for min_diff
    var $min_diff { value = 2147483647 }
    var $i { value = 1 }
    
    while ($i < ($values|count)) {
      each {
        var $current_val { value = $values|slice:$i:($i + 1)|first }
        var $prev_val { value = $values|slice:($i - 1):$i|first }
        var $diff { value = $current_val - $prev_val }
        conditional {
          if ($diff < 0) {
            var $diff { value = 0 - $diff }
          }
        }
        
        conditional {
          if ($diff < $min_diff) {
            var $min_diff { value = $diff }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $min_diff
}
