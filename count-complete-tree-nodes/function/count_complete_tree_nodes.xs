function "count_complete_tree_nodes" {
  description = "Count nodes in a complete binary tree using O(log²n) algorithm"
  input {
    int[] tree?
  }
  stack {
    // Handle empty tree
    conditional {
      if ($input.tree == null || ($input.tree|count) == 0) {
        var $result { value = 0 }
      }
      else {
        // Call recursive helper function
        function.run "count_nodes_helper" {
          input = {
            tree: $input.tree,
            index: 0
          }
        } as $count_result
        var $result { value = $count_result }
      }
    }
  }
  response = $result
}
