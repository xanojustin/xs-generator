// Binary Tree Post-Order Traversal
// Performs post-order traversal: left subtree -> right subtree -> root
// Returns an array of values in traversal order
function "binary_tree_postorder" {
  description = "Performs post-order traversal of a binary tree and returns values"

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
    var $output_stack { value = [] }

    while (($stack|count) > 0) {
      each {
        // Pop from stack
        var $node_idx { value = $stack|last }
        var $stack {
          value = $stack|slice:0:-1
        }

        // Push to output stack (this reverses the order)
        var $output_stack {
          value = $output_stack|merge:[$node_idx]
        }

        // Get the node
        var $node { value = $input.nodes[$node_idx] }

        // Push left first (so it's processed after right)
        var $left_idx { value = $node|get:"left":null }
        conditional {
          if ($left_idx != null) {
            var $stack {
              value = $stack|merge:[$left_idx]
            }
          }
        }

        // Push right
        var $right_idx { value = $node|get:"right":null }
        conditional {
          if ($right_idx != null) {
            var $stack {
              value = $stack|merge:[$right_idx]
            }
          }
        }
      }
    }

    // Process output_stack in reverse to get post-order
    var $i { value = ($output_stack|count) - 1 }
    while ($i >= 0) {
      each {
        var $node_idx { value = $output_stack[$i] }
        var $node { value = $input.nodes[$node_idx] }
        var $node_value { value = $node|get:"value":0 }
        var $result {
          value = $result|merge:[$node_value]
        }
        var.update $i { value = $i - 1 }
      }
    }
  }

  response = $result
}
