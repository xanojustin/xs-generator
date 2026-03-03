// Path Sum II - Find all root-to-leaf paths where sum equals target
// Given a binary tree and a target sum, find all root-to-leaf paths
// where each path's sum equals the target sum
function "path_sum_ii" {
  description = "Finds all root-to-leaf paths where path sum equals target"

  input {
    json root { description = "Binary tree root node with val, left, right properties" }
    int target_sum { description = "Target sum for root-to-leaf paths" }
  }

  stack {
    var $result { value = [] }

    // Iterative DFS using explicit stacks
    var $node_stack { value = [] }
    var $path_stack { value = [] }
    var $sum_stack { value = [] }

    // Initialize with root if not null
    conditional {
      if ($input.root != null) {
        var $node_stack {
          value = [$input.root]
        }
        var $path_stack {
          value = [[$input.root.val]]
        }
        var $sum_stack {
          value = [$input.root.val]
        }
      }
    }

    // Iterative DFS traversal
    var $stack_size { value = $node_stack|count }

    while ($stack_size > 0) {
      each {
        // Pop from stacks
        var $current_node {
          value = $node_stack|last
        }
        var $current_path {
          value = $path_stack|last
        }
        var $current_sum {
          value = $sum_stack|last
        }

        // Remove last element from stacks
        var $node_stack {
          value = $node_stack|slice:0:($stack_size - 1)
        }
        var $path_stack {
          value = $path_stack|slice:0:($stack_size - 1)
        }
        var $sum_stack {
          value = $sum_stack|slice:0:($stack_size - 1)
        }

        // Check if leaf node (no children)
        var $is_leaf {
          value = ($current_node.left == null) && ($current_node.right == null)
        }

        conditional {
          if ($is_leaf && $current_sum == $input.target_sum) {
            // Found a valid path
            var $result {
              value = $result|merge:[$current_path]
            }
          }
        }

        // Push right child first (so left is processed first)
        conditional {
          if ($current_node.right != null) {
            var $right_val {
              value = $current_node.right.val
            }
            var $new_path {
              value = $current_path|merge:[$right_val]
            }
            var $new_sum {
              value = $current_sum + $right_val
            }
            var $node_stack {
              value = $node_stack|merge:[$current_node.right]
            }
            var $path_stack {
              value = $path_stack|merge:[$new_path]
            }
            var $sum_stack {
              value = $sum_stack|merge:[$new_sum]
            }
          }
        }

        // Push left child
        conditional {
          if ($current_node.left != null) {
            var $left_val {
              value = $current_node.left.val
            }
            var $new_path {
              value = $current_path|merge:[$left_val]
            }
            var $new_sum {
              value = $current_sum + $left_val
            }
            var $node_stack {
              value = $node_stack|merge:[$current_node.left]
            }
            var $path_stack {
              value = $path_stack|merge:[$new_path]
            }
            var $sum_stack {
              value = $sum_stack|merge:[$new_sum]
            }
          }
        }

        // Update stack size for loop condition
        var $stack_size {
          value = $node_stack|count
        }
      }
    }
  }

  response = $result
}
