// Binary Tree Pre-Order Traversal
// Performs pre-order traversal: root -> left subtree -> right subtree
// Returns an array of values in traversal order
function "binary_tree_preorder" {
  description = "Performs pre-order traversal of a binary tree and returns values"
  
  input {
    // Array of nodes: each node has value, left (index), right (index)
    json nodes { description = "Array of tree nodes with value, left index, right index" }
    int root_index { description = "Index of the root node in the array" }
  }
  
  stack {
    // Handle empty tree
    conditional {
      if (($input.nodes|count) == 0) {
        return { value = [] }
      }
    }
    
    var $result { value = [] }
    var $stack { value = [$input.root_index] }
    
    while (($stack|count) > 0) {
      each {
        // Pop node index from stack
        var $node_idx { value = $stack|last }
        var $stack {
          value = $stack|slice:0:-1
        }
        
        // Get the node and add its value to result (visit root first in pre-order)
        var $node { value = $input.nodes[$node_idx] }
        var $node_value { value = $node|get:"value":0 }
        var $result {
          value = $result|merge:[$node_value]
        }
        
        // Push right child first (so left is processed first - LIFO stack)
        // In pre-order: root, left, right
        // Stack is LIFO, so push right first, then left
        var $right_idx { value = $node|get:"right":null }
        var $left_idx { value = $node|get:"left":null }
        
        conditional {
          if ($right_idx != null) {
            var $stack {
              value = $stack|merge:[$right_idx]
            }
          }
        }
        
        conditional {
          if ($left_idx != null) {
            var $stack {
              value = $stack|merge:[$left_idx]
            }
          }
        }
      }
    }
  }
  
  response = $result
}
