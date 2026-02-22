function "zigzag_level_order" {
  description = "Performs zigzag level order traversal on a binary tree"
  input {
    json tree {
      description = "Binary tree node structure"
    }
  }
  stack {
    // Handle empty tree
    conditional {
      if ($input.tree == null) {
        return { value = [] }
      }
    }

    // Initialize result and queue for BFS
    var $result { value = [] }
    var $queue { value = [$input.tree] }
    var $left_to_right { value = true }

    // Process levels until queue is empty
    while (($queue|count) > 0) {
      each {
        // Get number of nodes at current level
        var $level_size { value = $queue|count }
        var $current_level { value = [] }
        var $i { value = 0 }

        // Process all nodes at current level
        while ($i < $level_size) {
          each {
            // Dequeue node (take from front)
            var $node { value = $queue|first }
            var $rest { value = $queue|slice:1 }
            var.update $queue { value = $rest }

            // Add node value to current level
            conditional {
              if ($node.val != null) {
                var.update $current_level { value = $current_level|merge:[$node.val] }
              }
            }

            // Enqueue children (left first, then right)
            conditional {
              if ($node.left != null) {
                var.update $queue { value = $queue|merge:[$node.left] }
              }
            }
            conditional {
              if ($node.right != null) {
                var.update $queue { value = $queue|merge:[$node.right] }
              }
            }

            var.update $i { value = $i + 1 }
          }
        }

        // Add current level to result (reverse if going right-to-left)
        conditional {
          if ($left_to_right) {
            var.update $result { value = $result|merge:[$current_level] }
          }
          else {
            var $reversed { value = $current_level|reverse }
            var.update $result { value = $result|merge:[$reversed] }
          }
        }

        // Toggle direction
        var.update $left_to_right { value = !$left_to_right }
      }
    }
  }
  response = $result
}
