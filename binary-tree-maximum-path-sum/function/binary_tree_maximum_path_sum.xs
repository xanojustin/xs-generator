// Binary Tree Maximum Path Sum
// Given the root of a binary tree, return the maximum path sum of any non-empty path
// A path is any sequence of nodes from some starting node to any node in the tree
// along parent-child connections. The path must contain at least one node.
function "binary_tree_maximum_path_sum" {
  description = "Finds the maximum path sum in a binary tree"
  
  input {
    json tree {
      description = "Binary tree node with val, left, and right properties. Null for empty tree."
    }
  }
  
  stack {
    // Handle empty tree case
    conditional {
      if ($input.tree == null) {
        return { value = 0 }
      }
    }
    
    // Use helper function to compute result
    // Returns object with max_ending_here (can extend up) and max_overall
    function.run "max_path_helper" {
      input = { tree: $input.tree }
    } as $result
    
    var $max_sum {
      value = $result|get:"max_overall":0
    }
  }
  
  response = $max_sum
}
