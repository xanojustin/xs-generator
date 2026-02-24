// Path Sum - Binary Tree Exercise
// Given a binary tree and a target sum, determine if the tree has a root-to-leaf path
// such that adding up all the values along the path equals the given sum.
function "path_sum" {
  description = "Determines if there's a root-to-leaf path with the given target sum"

  input {
    json tree { description = "Binary tree node with val, left, and right properties" }
    int target_sum { description = "The target sum to find on a root-to-leaf path" }
  }

  stack {
    // Helper function using iteration with a stack
    var $stack { value = [] }
    
    // Push root node with current sum = 0
    // Each stack entry is an object with node and current_sum
    var $root_entry { 
      value = {
        node: $input.tree,
        current_sum: 0
      }
    }
    array.push $stack {
      value = $root_entry
    }
    
    // Handle empty tree case
    conditional {
      if ($input.tree == null) {
        return { value = false }
      }
    }
    
    // Iterative DFS using our stack
    while (($stack|count) > 0) {
      each {
        // Pop the top entry using array.pop
        array.pop $stack as $entry
        
        var $node { value = $entry.node }
        var $current_sum { value = $entry.current_sum + $node.val }
        
        // Check if this is a leaf node
        var $is_leaf { value = true }
        conditional {
          if ($node.left != null) {
            var.update $is_leaf { value = false }
          }
        }
        conditional {
          if ($node.right != null) {
            var.update $is_leaf { value = false }
          }
        }
        
        conditional {
          if ($is_leaf == true) {
            // Leaf node - check if sum matches target
            conditional {
              if ($current_sum == $input.target_sum) {
                return { value = true }
              }
            }
          }
        }
        
        // Push children to stack (right first so left is processed first)
        conditional {
          if ($node.right != null) {
            var $right_entry {
              value = {
                node: $node.right,
                current_sum: $current_sum
              }
            }
            array.push $stack {
              value = $right_entry
            }
          }
        }
        
        conditional {
          if ($node.left != null) {
            var $left_entry {
              value = {
                node: $node.left,
                current_sum: $current_sum
              }
            }
            array.push $stack {
              value = $left_entry
            }
          }
        }
      }
    }
  }

  response = false
}
