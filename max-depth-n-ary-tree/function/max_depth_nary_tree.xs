// Maximum Depth of N-ary Tree
// Given the root of an n-ary tree, returns its maximum depth
// Maximum depth is the number of nodes along the longest path
// from the root node down to the farthest leaf node
// Each node has a val and a children array (which can be empty)
function "max_depth_nary_tree" {
  description = "Calculate the maximum depth of an n-ary tree"

  input {
    json tree {
      description = "N-ary tree node with val and children array. Null for empty tree."
    }
  }

  stack {
    // Base case: empty tree has depth 0
    conditional {
      if ($input.tree == null) {
        return { value = 0 }
      }
    }

    // Get children array
    var $children {
      value = $input.tree|get:"children":[]
    }

    // If no children, depth is 1 (just the current node)
    conditional {
      if (($children|count) == 0) {
        return { value = 1 }
      }
    }

    // Find maximum depth among all children
    var $max_child_depth {
      value = 0
    }

    // Iterate through each child
    foreach ($children) {
      each as $child {
        // Recursively get depth of this child
        function.run "max_depth_nary_tree" {
          input = { tree: $child }
        } as $child_depth

        // Update max_child_depth if this child is deeper
        conditional {
          if ($child_depth > $max_child_depth) {
            var.update $max_child_depth {
              value = $child_depth
            }
          }
        }
      }
    }

    // Total depth is 1 (current node) + max depth of deepest child
    var $total_depth {
      value = 1 + $max_child_depth
    }
  }

  response = $total_depth
}
