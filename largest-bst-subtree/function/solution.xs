function "largest_bst_subtree" {
  description = "Find the size of the largest subtree that is a valid Binary Search Tree"
  
  input {
    json tree {
      description = "Binary tree represented as nested objects with val, left, right properties"
    }
  }
  
  stack {
    // Helper function to check if a tree is BST and get its size
    // Returns: { is_bst: bool, size: int, min_val: int, max_val: int }
    var $check_bst {
      value = {
        func: ""
      }
    }
    
    // Define a recursive function using iteration with a stack
    // We'll use a post-order traversal approach
    
    // Stack for iterative traversal: each element is { node: {}, visited: bool }
    var $stack {
      value = []
    }
    
    // Result map: node_id -> { is_bst: bool, size: int, min_val: int, max_val: int }
    var $results {
      value = {}
    }
    
    // Start with root if tree exists
    conditional {
      if ($input.tree == null) {
        return { value = 0 }
      }
    }
    
    // Build traversal stack with post-order processing
    // We'll use a simple approach: process all nodes and store results
    var $nodes_to_process {
      value = [$input.tree]
    }
    
    var $all_nodes {
      value = []
    }
    
    // Collect all nodes using BFS/DFS first
    while (($nodes_to_process|count) > 0) {
      each {
        var $current {
          value = $nodes_to_process|first
        }
        var.update $nodes_to_process {
          value = $nodes_to_process|slice:1
        }
        
        conditional {
          if ($current != null) {
            var.update $all_nodes {
              value = $all_nodes|merge:[$current]
            }
            conditional {
              if ($current|has:"left") {
                conditional {
                  if ($current.left != null) {
                    var.update $nodes_to_process {
                      value = $nodes_to_process|merge:[$current.left]
                    }
                  }
                }
              }
            }
            conditional {
              if ($current|has:"right") {
                conditional {
                  if ($current.right != null) {
                    var.update $nodes_to_process {
                      value = $nodes_to_process|merge:[$current.right]
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    
    // Now process nodes in reverse order (leaves first) to simulate post-order
    var $i {
      value = ($all_nodes|count) - 1
    }
    
    var $max_bst_size {
      value = 0
    }
    
    // Create a map to track which object is which
    // Since we can't use object identity, we'll use the object's position in all_nodes
    
    while ($i >= 0) {
      each {
        var $node {
          value = $all_nodes[$i]
        }
        var $node_val {
          value = $node.val ?? 0
        }
        
        // Get left child result if exists
        var $left_result {
          value = { is_bst: true, size: 0, min_val: $node_val, max_val: $node_val }
        }
        
        conditional {
          if ($node|has:"left") {
            conditional {
              if ($node.left != null) {
                // Find left child index
                var $left_idx {
                  value = 0
                }
                var $j {
                  value = 0
                }
                while ($j < ($all_nodes|count)) {
                  each {
                    conditional {
                      if ($all_nodes[$j] == $node.left) {
                        var.update $left_idx {
                          value = $j
                        }
                        var.update $j {
                          value = ($all_nodes|count) + 1
                        }
                      }
                    }
                    var.update $j {
                      value = $j + 1
                    }
                  }
                }
                var.update $left_result {
                  value = $results|get:($left_idx|to_text)
                }
              }
            }
          }
        }
        
        // Get right child result if exists
        var $right_result {
          value = { is_bst: true, size: 0, min_val: $node_val, max_val: $node_val }
        }
        
        conditional {
          if ($node|has:"right") {
            conditional {
              if ($node.right != null) {
                // Find right child index
                var $right_idx {
                  value = 0
                }
                var $k {
                  value = 0
                }
                while ($k < ($all_nodes|count)) {
                  each {
                    conditional {
                      if ($all_nodes[$k] == $node.right) {
                        var.update $right_idx {
                          value = $k
                        }
                        var.update $k {
                          value = ($all_nodes|count) + 1
                        }
                      }
                    }
                    var.update $k {
                      value = $k + 1
                    }
                  }
                }
                var.update $right_result {
                  value = $results|get:($right_idx|to_text)
                }
              }
            }
          }
        }
        
        // Determine if current node forms a BST
        var $current_is_bst {
          value = false
        }
        
        conditional {
          if ($left_result.is_bst && $right_result.is_bst) {
            // Check BST property: left.max < node.val < right.min
            var $left_valid {
              value = ($left_result.size == 0) || ($left_result.max_val < $node_val)
            }
            var $right_valid {
              value = ($right_result.size == 0) || ($right_result.min_val > $node_val)
            }
            
            conditional {
              if ($left_valid && $right_valid) {
                var.update $current_is_bst {
                  value = true
                }
              }
            }
          }
        }
        
        // Calculate min/max for this subtree
        var $current_min {
          value = $node_val
        }
        var $current_max {
          value = $node_val
        }
        
        conditional {
          if ($left_result.size > 0) {
            var.update $current_min {
              value = ($left_result.min_val < $current_min) ? $left_result.min_val : $current_min
            }
          }
        }
        
        conditional {
          if ($right_result.size > 0) {
            var.update $current_max {
              value = ($right_result.max_val > $current_max) ? $right_result.max_val : $current_max
            }
          }
        }
        
        // Calculate size of current subtree if it's a BST
        var $current_size {
          value = 0
        }
        
        conditional {
          if ($current_is_bst) {
            var.update $current_size {
              value = 1 + $left_result.size + $right_result.size
            }
          }
          else {
            // Not a BST - size is 0 (we'll still track children for max calculation)
            var.update $current_size {
              value = 0
            }
          }
        }
        
        // Store result for this node
        var $node_result {
          value = {
            is_bst: $current_is_bst,
            size: $current_size,
            min_val: $current_min,
            max_val: $current_max
          }
        }
        
        var.update $results {
          value = $results|set:($i|to_text):$node_result
        }
        
        // Update max BST size found
        conditional {
          if ($current_size > $max_bst_size) {
            var.update $max_bst_size {
              value = $current_size
            }
          }
        }
        
        var.update $i {
          value = $i - 1
        }
      }
    }
    
    // Return the largest BST size found (at least 1 for a single node)
    conditional {
      if ($max_bst_size == 0 && ($all_nodes|count) > 0) {
        var.update $max_bst_size {
          value = 1
        }
      }
    }
  }
  
  response = $max_bst_size ?? 0
}
