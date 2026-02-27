function "flatten_tree" {
  description = "Flatten a binary tree to a linked list in-place using Morris traversal"
  input {
    json tree {
      description = "Binary tree node with val, left, and right properties"
    }
  }
  stack {
    // Handle empty tree
    conditional {
      if ($input.tree == null) {
        return { value = null }
      }
    }

    // Use Morris traversal to flatten tree in-place
    // This gives us O(1) space complexity
    var $current { value = $input.tree }

    while ($current != null) {
      each {
        conditional {
          if ($current.left != null) {
            // Find the rightmost node in the left subtree
            var $rightmost { value = $current.left }
            
            while ($rightmost.right != null) {
              each {
                var.update $rightmost { value = $rightmost.right }
              }
            }
            
            // Rewire the pointers
            // 1. Rightmost node's right points to current's right
            var.update $rightmost.right { value = $current.right }
            
            // 2. Current's right points to current's left
            var.update $current.right { value = $current.left }
            
            // 3. Current's left becomes null
            var.update $current.left { value = null }
          }
        }
        
        // Move to the next node (which is now in the right pointer)
        var.update $current { value = $current.right }
      }
    }
  }
  response = $input.tree
}
