// Maximum Depth of Binary Tree
// Given the root of a binary tree, returns its maximum depth
// Maximum depth is the number of nodes along the longest path 
// from the root node down to the farthest leaf node
function "maximum_depth_binary_tree" {
  description = "Calculate the maximum depth of a binary tree"
  
  input {
    json tree {
      description = "Binary tree node with val, left, and right properties. Null for empty tree."
    }
  }
  
  stack {
    // Base case: empty tree has depth 0
    conditional {
      if ($input.tree == null) {
        return { value = 0 }
      }
    }
    
    // Get left and right subtrees
    var $left_subtree {
      value = $input.tree|get:"left":null
    }
    var $right_subtree {
      value = $input.tree|get:"right":null
    }
    
    // Recursively calculate depth of left subtree
    var $left_depth {
      value = 0
    }
    conditional {
      if ($left_subtree != null) {
        function.run "maximum_depth_binary_tree" {
          input = { tree: $left_subtree }
        } as $left_result
        var.update $left_depth {
          value = $left_result
        }
      }
    }
    
    // Recursively calculate depth of right subtree
    var $right_depth {
      value = 0
    }
    conditional {
      if ($right_subtree != null) {
        function.run "maximum_depth_binary_tree" {
          input = { tree: $right_subtree }
        } as $right_result
        var.update $right_depth {
          value = $right_result
        }
      }
    }
    
    // Maximum depth is 1 (current node) + max of left and right depths
    var $max_depth {
      value = 1
    }
    conditional {
      if ($left_depth > $right_depth) {
        var.update $max_depth {
          value = 1 + $left_depth
        }
      }
      else {
        var.update $max_depth {
          value = 1 + $right_depth
        }
      }
    }
  }
  
  response = $max_depth
}
