// Helper function for binary_tree_maximum_path_sum
// Returns both max gain (path that can extend upward to parent) and max overall path sum
function "max_path_helper" {
  description = "Helper to compute max path sum - returns object with max_ending_here and max_overall"
  
  input {
    json tree {
      description = "Binary tree node with val, left, and right properties."
    }
  }
  
  stack {
    // Get current node value
    var $node_val {
      value = $input.tree|get:"val":0
    }
    
    // Get left and right subtrees
    var $left_subtree {
      value = $input.tree|get:"left":null
    }
    var $right_subtree {
      value = $input.tree|get:"right":null
    }
    
    // Initialize results
    var $left_ending_here {
      value = 0
    }
    var $left_overall {
      value = -999999999
    }
    var $right_ending_here {
      value = 0
    }
    var $right_overall {
      value = -999999999
    }
    
    // Process left subtree
    conditional {
      if ($left_subtree != null) {
        function.run "max_path_helper" {
          input = { tree: $left_subtree }
        } as $left_result
        var $left_gain {
          value = $left_result|get:"max_ending_here":0
        }
        var $left_found_max {
          value = $left_result|get:"max_overall":-999999999
        }
        conditional {
          if ($left_gain > 0) {
            var.update $left_ending_here {
              value = $left_gain
            }
          }
        }
        var.update $left_overall {
          value = $left_found_max
        }
      }
    }
    
    // Process right subtree
    conditional {
      if ($right_subtree != null) {
        function.run "max_path_helper" {
          input = { tree: $right_subtree }
        } as $right_result
        var $right_gain {
          value = $right_result|get:"max_ending_here":0
        }
        var $right_found_max {
          value = $right_result|get:"max_overall":-999999999
        }
        conditional {
          if ($right_gain > 0) {
            var.update $right_ending_here {
              value = $right_gain
            }
          }
        }
        var.update $right_overall {
          value = $right_found_max
        }
      }
    }
    
    // Max ending at current node (can extend upward) - max of node alone, node+left, node+right
    var $max_ending_here {
      value = $node_val
    }
    conditional {
      if ($node_val + $left_ending_here > $max_ending_here) {
        var.update $max_ending_here {
          value = $node_val + $left_ending_here
        }
      }
    }
    conditional {
      if ($node_val + $right_ending_here > $max_ending_here) {
        var.update $max_ending_here {
          value = $node_val + $right_ending_here
        }
      }
    }
    
    // Max path through current node (node + left + right - cannot extend up)
    var $max_through_node {
      value = $node_val + $left_ending_here + $right_ending_here
    }
    
    // Max overall in this subtree
    var $max_overall {
      value = $max_through_node
    }
    conditional {
      if ($left_overall > $max_overall) {
        var.update $max_overall {
          value = $left_overall
        }
      }
    }
    conditional {
      if ($right_overall > $max_overall) {
        var.update $max_overall {
          value = $right_overall
        }
      }
    }
    
    // Build result object
    var $result_obj {
      value = {
        max_ending_here: $max_ending_here,
        max_overall: $max_overall
      }
    }
  }
  
  response = $result_obj
}
