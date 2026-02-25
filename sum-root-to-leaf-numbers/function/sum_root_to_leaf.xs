// Sum Root to Leaf Numbers
// Given a binary tree where each node contains a digit (0-9),
// each root-to-leaf path represents a number. Return the sum of all such numbers.
function "sum_root_to_leaf" {
  description = "Sums all root-to-leaf path numbers in a binary tree"

  input {
    json tree { description = "Binary tree node with val (int 0-9), left (json), and right (json) properties" }
  }

  stack {
    // Handle empty tree case
    conditional {
      if ($input.tree == null) {
        return { value = 0 }
      }
    }

    // Stack for iterative DFS - each entry contains node and current number formed
    var $stack { value = [] }
    var $total_sum { value = 0 }

    // Push root node with current number = root's value
    var $root_entry {
      value = {
        node: $input.tree,
        current_num: $input.tree.val
      }
    }
    array.push $stack {
      value = $root_entry
    }

    // Iterative DFS
    while (($stack|count) > 0) {
      each {
        // Pop from stack
        array.pop $stack as $entry

        var $node { value = $entry.node }
        var $current_num { value = $entry.current_num }

        // Check if this is a leaf node (no children)
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
            // Leaf node - add current number to total sum
            math.add $total_sum {
              value = $current_num
            }
          }
          else {
            // Not a leaf - push children with updated numbers
            // current_num * 10 + child.val forms the new number
            conditional {
              if ($node.right != null) {
                var $new_num_right {
                  value = ($current_num * 10) + $node.right.val
                }
                var $right_entry {
                  value = {
                    node: $node.right,
                    current_num: $new_num_right
                  }
                }
                array.push $stack {
                  value = $right_entry
                }
              }
            }

            conditional {
              if ($node.left != null) {
                var $new_num_left {
                  value = ($current_num * 10) + $node.left.val
                }
                var $left_entry {
                  value = {
                    node: $node.left,
                    current_num: $new_num_left
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
    }
  }

  response = $total_sum
}
