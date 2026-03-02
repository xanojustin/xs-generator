// Binary Tree Vertical Order Traversal
// Given a binary tree, return the vertical order traversal of its nodes' values
// (from top to bottom, left to right within the same column)
function "vertical_order" {
  description = "Returns vertical order traversal of a binary tree"

  input {
    object root {
      description = "Root node of the binary tree"
      schema {
        int val
        object? left {
          schema {
            int val
            json left?
            json right?
          }
        }
        object? right {
          schema {
            int val
            json left?
            json right?
          }
        }
      }
    }
  }

  stack {
    // Handle empty tree
    conditional {
      if ($input.root == null) {
        return { value = [] }
      }
    }

    // Queue for BFS: each element is [node, column]
    var $queue { value = [{ node: $input.root, col: 0 }] }
    var $column_map { value = {} }
    var $min_col { value = 0 }
    var $max_col { value = 0 }

    // BFS traversal
    while (($queue|count) > 0) {
      each {
        // Dequeue first element
        var $current { value = $queue[0] }
        var $node { value = $current|get:"node" }
        var $col { value = $current|get:"col" }
        
        // Remove first element from queue
        var $queue {
          value = $queue|filter:($queue|first) != $$
        }

        // Add node value to its column
        var $col_key { value = $col|to_text }
        var $col_values { value = $column_map|get:$col_key }
        
        conditional {
          if ($col_values == null) {
            var $column_map {
              value = $column_map|set:$col_key:[$node|get:"val"]
            }
          }
          else {
            var $new_values { value = $col_values|push:($node|get:"val") }
            var $column_map {
              value = $column_map|set:$col_key:$new_values
            }
          }
        }

        // Update min/max column trackers
        conditional {
          if ($col < $min_col) {
            var $min_col { value = $col }
          }
        }
        conditional {
          if ($col > $max_col) {
            var $max_col { value = $col }
          }
        }

        // Add left child (column - 1)
        var $left { value = $node|get:"left" }
        conditional {
          if ($left != null) {
            var $queue {
              value = $queue|push:{ node: $left, col: $col - 1 }
            }
          }
        }

        // Add right child (column + 1)
        var $right { value = $node|get:"right" }
        conditional {
          if ($right != null) {
            var $queue {
              value = $queue|push:{ node: $right, col: $col + 1 }
            }
          }
        }
      }
    }

    // Build result array from min_col to max_col
    var $result { value = [] }
    var $current_col { value = $min_col }
    
    while ($current_col <= $max_col) {
      each {
        var $col_key { value = $current_col|to_text }
        var $col_values { value = $column_map|get:$col_key }
        conditional {
          if ($col_values != null) {
            var $result {
              value = $result|push:$col_values
            }
          }
        }
        var $current_col { value = $current_col + 1 }
      }
    }
  }

  response = $result
}
