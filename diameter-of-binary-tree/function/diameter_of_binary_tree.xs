// Diameter of Binary Tree
// Given the root of a binary tree, returns the diameter
// The diameter is the length of the longest path between any two nodes in the tree
// This path may or may not pass through the root
function "diameter_of_binary_tree" {
  description = "Calculate the diameter of a binary tree"
  
  input {
    json tree {
      description = "Binary tree node with val, left, and right properties. Null for empty tree."
    }
  }
  
  stack {
    // Base case: empty tree has diameter 0 and height 0
    conditional {
      if ($input.tree == null) {
        return { 
          value = {
            diameter: 0
            height: 0
          }
        }
      }
    }
    
    // Get left and right subtrees
    var $left_subtree {
      value = $input.tree|get:"left":null
    }
    var $right_subtree {
      value = $input.tree|get:"right":null
    }
    
    // Recursively calculate diameter and height of left subtree
    var $left_diameter {
      value = 0
    }
    var $left_height {
      value = 0
    }
    conditional {
      if ($left_subtree != null) {
        function.run "diameter_of_binary_tree" {
          input = { tree: $left_subtree }
        } as $left_result
        var.update $left_diameter {
          value = $left_result|get:"diameter":0
        }
        var.update $left_height {
          value = $left_result|get:"height":0
        }
      }
    }
    
    // Recursively calculate diameter and height of right subtree
    var $right_diameter {
      value = 0
    }
    var $right_height {
      value = 0
    }
    conditional {
      if ($right_subtree != null) {
        function.run "diameter_of_binary_tree" {
          input = { tree: $right_subtree }
        } as $right_result
        var.update $right_diameter {
          value = $right_result|get:"diameter":0
        }
        var.update $right_height {
          value = $right_result|get:"height":0
        }
      }
    }
    
    // Path through current node = left_height + right_height
    var $path_through_root {
      value = $left_height + $right_height
    }
    
    // Diameter is max of: path through root, left diameter, right diameter
    var $max_diameter {
      value = $path_through_root
    }
    conditional {
      if ($left_diameter > $max_diameter) {
        var.update $max_diameter {
          value = $left_diameter
        }
      }
    }
    conditional {
      if ($right_diameter > $max_diameter) {
        var.update $max_diameter {
          value = $right_diameter
        }
      }
    }
    
    // Height of current node = 1 + max(left_height, right_height)
    var $current_height {
      value = 1
    }
    conditional {
      if ($left_height > $right_height) {
        var.update $current_height {
          value = 1 + $left_height
        }
      }
      else {
        var.update $current_height {
          value = 1 + $right_height
        }
      }
    }
    
    // Prepare result object
    var $result {
      value = {
        diameter: $max_diameter
        height: $current_height
      }
    }
  }
  
  response = $result
}