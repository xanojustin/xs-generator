// House Robber III - Binary Tree Dynamic Programming
// The thief cannot rob adjacent nodes (parent-child)
// Returns the maximum amount that can be robbed
function "house-robber-iii" {
  description = "Find maximum money that can be robbed from binary tree without robbing adjacent nodes"
  
  input {
    json tree {
      description = "Binary tree node with val, left, and right properties (null for empty tree)"
    }
  }
  
  stack {
    // Base case: null tree returns 0 (we'll handle this at each level)
    conditional {
      if ($input.tree == null) {
        return { value = 0 }
      }
    }
    
    // Get node value
    var $node_val {
      value = $input.tree|get:"val":0|to_int
    }
    
    // Get left and right children
    var $left_node {
      value = $input.tree|get:"left":null
    }
    var $right_node {
      value = $input.tree|get:"right":null
    }
    
    // Calculate grandchildren values (if we rob this node, we can't rob children)
    var $grandchild_left_left {
      value = 0
    }
    var $grandchild_left_right {
      value = 0
    }
    var $grandchild_right_left {
      value = 0
    }
    var $grandchild_right_right {
      value = 0
    }
    
    // Get left child's children (our grandchildren)
    conditional {
      if ($left_node != null) {
        var $left_left {
          value = $left_node|get:"left":null
        }
        var $left_right {
          value = $left_node|get:"right":null
        }
        
        // Recursively get value from left-left grandchild
        conditional {
          if ($left_left != null) {
            function.run "house-robber-iii" {
              input = { tree: $left_left }
            } as $left_left_result
            var.update $grandchild_left_left { value = $left_left_result }
          }
        }
        
        // Recursively get value from left-right grandchild
        conditional {
          if ($left_right != null) {
            function.run "house-robber-iii" {
              input = { tree: $left_right }
            } as $left_right_result
            var.update $grandchild_left_right { value = $left_right_result }
          }
        }
      }
    }
    
    // Get right child's children (our grandchildren)
    conditional {
      if ($right_node != null) {
        var $right_left {
          value = $right_node|get:"left":null
        }
        var $right_right {
          value = $right_node|get:"right":null
        }
        
        // Recursively get value from right-left grandchild
        conditional {
          if ($right_left != null) {
            function.run "house-robber-iii" {
              input = { tree: $right_left }
            } as $right_left_result
            var.update $grandchild_right_left { value = $right_left_result }
          }
        }
        
        // Recursively get value from right-right grandchild
        conditional {
          if ($right_right != null) {
            function.run "house-robber-iii" {
              input = { tree: $right_right }
            } as $right_right_result
            var.update $grandchild_right_right { value = $right_right_result }
          }
        }
      }
    }
    
    // Value if we rob this node: node.val + all grandchildren values
    var $rob_this {
      value = $node_val + $grandchild_left_left + $grandchild_left_right + $grandchild_right_left + $grandchild_right_right
    }
    
    // Value if we don't rob this node: get values from left and right children
    var $left_value {
      value = 0
    }
    var $right_value {
      value = 0
    }
    
    conditional {
      if ($left_node != null) {
        function.run "house-robber-iii" {
          input = { tree: $left_node }
        } as $left_result
        var.update $left_value { value = $left_result }
      }
    }
    
    conditional {
      if ($right_node != null) {
        function.run "house-robber-iii" {
          input = { tree: $right_node }
        } as $right_result
        var.update $right_value { value = $right_result }
      }
    }
    
    var $skip_this {
      value = $left_value + $right_value
    }
    
    // Return the maximum of robbing or not robbing this node
    var $result {
      value = $skip_this
    }
    conditional {
      if ($rob_this > $result) {
        var.update $result { value = $rob_this }
      }
    }
  }
  
  response = $result
}
