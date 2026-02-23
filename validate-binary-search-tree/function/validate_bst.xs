function "validate_bst" {
  description = "Validate if a binary tree is a valid Binary Search Tree (BST)"
  
  input {
    json tree {
      description = "Binary tree represented as nested objects with val, left, and right properties"
    }
  }
  
  stack {
    // Helper function using iterative approach with stack
    var $is_valid { value = true }
    var $stack { value = [] }
    var $prev_val { value = null }
    var $current { value = $input.tree }
    
    // Iterative in-order traversal
    while (($current != null) || (($stack|count) > 0)) {
      each {
        // Go to leftmost node
        while ($current != null) {
          each {
            var $stack_item { value = { node: $current } }
            var $new_stack { value = $stack|concat:[$stack_item] }
            var.update $stack { value = $new_stack }
            var.update $current { value = $current|get:"left" }
          }
        }
        
        // Process current node if stack not empty
        conditional {
          if (($stack|count) > 0) {
            var $top { value = $stack|last }
            var $node { value = $top|get:"node" }
            var $new_stack { value = $stack|slice:0:(($stack|count) - 1) }
            var.update $stack { value = $new_stack }
            
            var $node_val { value = $node|get:"val" }
            
            // Check BST property: current value must be greater than previous
            conditional {
              if ($prev_val != null) {
                conditional {
                  if ($node_val <= $prev_val) {
                    var.update $is_valid { value = false }
                  }
                }
              }
            }
            
            var.update $prev_val { value = $node_val }
            var.update $current { value = $node|get:"right" }
          }
        }
      }
    }
  }
  
  response = $is_valid
}
