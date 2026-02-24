// Sum of Left Leaves - Binary Tree Exercise
// Given the root of a binary tree, return the sum of all left leaves.
// A leaf is a node with no children. A left leaf is a leaf that is the left child of its parent.
function "sum_of_left_leaves" {
  description = "Calculate the sum of all left leaves in a binary tree"
  
  input {
    json tree { description = "Binary tree node with val, left, and right properties" }
  }
  
  stack {
    // Handle empty tree
    conditional {
      if ($input.tree == null) {
        return { value = 0 }
      }
    }
    
    // Use iterative DFS with a stack
    // Each entry is { node: <node>, is_left: <bool> }
    var $stack {
      value = [{ node: $input.tree, is_left: false }]
    }
    var $sum {
      value = 0
    }
    
    while (($stack|count) > 0) {
      each {
        // Pop the last element
        var $current {
          value = $stack|last
        }
        var $node {
          value = $current|get:"node"
        }
        var $is_left {
          value = $current|get:"is_left"
        }
        
        // Remove last element from stack
        var $stack {
          value = $stack|slice:0:-1
        }
        
        // Check if this is a left leaf
        var $left_child {
          value = $node|get:"left":null
        }
        var $right_child {
          value = $node|get:"right":null
        }
        
        conditional {
          if ($is_left && $left_child == null && $right_child == null) {
            // This is a left leaf - add its value
            var $node_val {
              value = $node|get:"val":0
            }
            var.update $sum {
              value = $sum + $node_val
            }
          }
        }
        
        // Push right child first (so left is processed first in DFS)
        conditional {
          if ($right_child != null) {
            var $stack {
              value = $stack|merge:[{ node: $right_child, is_left: false }]
            }
          }
        }
        
        conditional {
          if ($left_child != null) {
            var $stack {
              value = $stack|merge:[{ node: $left_child, is_left: true }]
            }
          }
        }
      }
    }
  }
  
  response = $sum
}
