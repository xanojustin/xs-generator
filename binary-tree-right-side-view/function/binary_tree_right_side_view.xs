// Binary Tree Right Side View
// Given the root of a binary tree, return the values of the nodes
// you can see when standing on the right side, ordered from top to bottom.
// Uses BFS level-order traversal to get the rightmost node at each level.
function "binary_tree_right_side_view" {
  description = "Returns the right side view of a binary tree"

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
    var $queue { value = [$input.root_index] }

    // BFS level-order traversal
    while (($queue|count) > 0) {
      each {
        // Number of nodes at current level
        var $level_size { value = $queue|count }
        var $i { value = 0 }
        var $rightmost_value { value = null }

        // Process all nodes at current level
        while ($i < $level_size) {
          each {
            // Dequeue node
            var $node_idx { value = $queue|first }
            var $queue {
              value = $queue|slice:1
            }

            var $node { value = $input.nodes[$node_idx] }
            var $rightmost_value { value = $node|get:"value":0 }

            // Enqueue left child if exists
            var $left_idx { value = $node|get:"left":null }
            conditional {
              if ($left_idx != null) {
                var $queue {
                  value = $queue|merge:[$left_idx]
                }
              }
            }

            // Enqueue right child if exists
            var $right_idx { value = $node|get:"right":null }
            conditional {
              if ($right_idx != null) {
                var $queue {
                  value = $queue|merge:[$right_idx]
                }
              }
            }

            var.update $i { value = $i + 1 }
          }
        }

        // Add rightmost value of this level to result
        var $result {
          value = $result|merge:[$rightmost_value]
        }
      }
    }
  }

  response = $result
}
