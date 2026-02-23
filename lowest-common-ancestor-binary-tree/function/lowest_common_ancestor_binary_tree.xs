// Lowest Common Ancestor of a Binary Tree
// Finds the lowest common ancestor (LCA) of two nodes in a binary tree
// The LCA is the lowest (deepest) node that has both p and q as descendants
function "lowest_common_ancestor_binary_tree" {
  description = "Finds the lowest common ancestor of two nodes in a binary tree"

  input {
    // Array of nodes: each node has value, left (index), right (index)
    json nodes { description = "Array of tree nodes with value, left index, right index" }
    int root_index { description = "Index of the root node in the array" }
    int p_value { description = "Value of the first target node" }
    int q_value { description = "Value of the second target node" }
  }

  stack {
    // Handle empty tree
    conditional {
      if (($input.nodes|count) == 0) {
        return { value = null }
      }
    }

    // Build a parent mapping: value -> parent_value
    // Also store node index by value for lookup
    var $parent_map { value = {} }
    var $value_to_index { value = {} }

    // Use BFS/DFS to build parent relationships
    var $stack { value = [$input.root_index] }
    var $parent_map {
      value = $parent_map|set:($input.nodes[$input.root_index]|get:"value"|to_text):null
    }
    var $value_to_index {
      value = $value_to_index|set:($input.nodes[$input.root_index]|get:"value"|to_text):$input.root_index
    }

    while (($stack|count) > 0) {
      each {
        var $node_idx { value = $stack|last }
        var $stack { value = $stack|slice:0:-1 }
        var $node { value = $input.nodes[$node_idx] }
        var $node_val { value = $node|get:"value"|to_text }

        var $left { value = $node|get:"left":null }
        var $right { value = $node|get:"right":null }

        conditional {
          if ($left != null) {
            var $left_node { value = $input.nodes[$left] }
            var $left_val { value = $left_node|get:"value"|to_text }
            var $parent_map {
              value = $parent_map|set:$left_val:$node_val
            }
            var $value_to_index {
              value = $value_to_index|set:$left_val:$left
            }
            var $stack { value = $stack|merge:[$left] }
          }
        }

        conditional {
          if ($right != null) {
            var $right_node { value = $input.nodes[$right] }
            var $right_val { value = $right_node|get:"value"|to_text }
            var $parent_map {
              value = $parent_map|set:$right_val:$node_val
            }
            var $value_to_index {
              value = $value_to_index|set:$right_val:$right
            }
            var $stack { value = $stack|merge:[$right] }
          }
        }
      }
    }

    // Check if p and q exist in the tree
    var $p_key { value = $input.p_value|to_text }
    var $q_key { value = $input.q_value|to_text }

    conditional {
      if (!(($value_to_index|has:$p_key) && ($value_to_index|has:$q_key))) {
        return { value = null }
      }
    }

    // Build path from p to root
    var $p_path { value = [] }
    var $current_val { value = $p_key }
    while ($current_val != null) {
      each {
        var $p_path { value = $p_path|merge:[$current_val] }
        var $current_val { value = $parent_map|get:$current_val:null }
      }
    }

    // Find LCA by walking up from q and checking against p's path
    var $lca_val { value = null }
    var $current_val { value = $q_key }
    var $found { value = false }

    while (($current_val != null) && !$found) {
      each {
        // Check if current is in p's path
        var $i { value = 0 }
        while (($i < ($p_path|count)) && !$found) {
          each {
            conditional {
              if ($p_path[$i] == $current_val) {
                var $lca_val { value = $current_val }
                var $found { value = true }
              }
            }
            var.update $i { value = $i + 1 }
          }
        }
        var $current_val { value = $parent_map|get:$current_val:null }
      }
    }

    // Return the actual node object
    conditional {
      if ($lca_val != null) {
        var $lca_index { value = $value_to_index|get:$lca_val:0 }
        return { value = $input.nodes[$lca_index] }
      }
    }
  }

  response = null
}
