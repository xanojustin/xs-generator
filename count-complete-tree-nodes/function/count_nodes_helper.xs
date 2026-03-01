function "count_nodes_helper" {
  description = "Helper function that recursively counts nodes using complete tree property"
  input {
    int[] tree
    int index
  }
  stack {
    // Base case: if index is out of bounds
    conditional {
      if ($input.index >= ($input.tree|count)) {
        var $result { value = 0 }
      }
      else {
        // Calculate left height (always go left: 2*i + 1)
        function.run "get_left_height" {
          input = {
            tree: $input.tree,
            index: $input.index
          }
        } as $left_height

        // Calculate right height (always go right: 2*i + 2)
        function.run "get_right_height" {
          input = {
            tree: $input.tree,
            index: $input.index
          }
        } as $right_height

        conditional {
          if ($left_height == $right_height) {
            // Tree is perfectly full, use formula: 2^height - 1
            // Calculate 2^height using a loop (XanoScript doesn't have bit shift)
            function.run "power_of_two" {
              input = { exponent: $left_height }
            } as $power_result
            var $full_count { value = $power_result - 1 }
            var $result { value = $full_count }
          }
          else {
            // Tree is not full, recurse on children
            var $left_child_idx { value = (2 * $input.index) + 1 }
            var $right_child_idx { value = (2 * $input.index) + 2 }

            function.run "count_nodes_helper" {
              input = {
                tree: $input.tree,
                index: $left_child_idx
              }
            } as $left_count

            function.run "count_nodes_helper" {
              input = {
                tree: $input.tree,
                index: $right_child_idx
              }
            } as $right_count

            // Current node (1) + left subtree + right subtree
            var $result { value = 1 + $left_count + $right_count }
          }
        }
      }
    }
  }
  response = $result
}
