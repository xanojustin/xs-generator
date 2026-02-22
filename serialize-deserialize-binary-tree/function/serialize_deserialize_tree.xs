function "serialize_deserialize_tree" {
  description = "Serialize a binary tree to string and deserialize it back"
  input {
    json tree? {
      description = "Binary tree node with val, left, and right properties"
    }
  }
  stack {
    // Serialize using level-order (BFS) traversal
    // Format: 1,2,3,null,null,4,5 represents:
    //       1
    //      / \
    //     2   3
    //        / \
    //       4   5
    
    var $serialized_values {
      value = []
    }
    
    // BFS queue: array of nodes
    var $queue {
      value = []
    }
    
    // Start with root
    conditional {
      if ($input.tree != null) {
        var $initial_queue {
          value = [$input.tree]
        }
        var.update $queue {
          value = $initial_queue
        }
      }
    }
    
    // BFS traversal
    var $queue_idx {
      value = 0
    }
    
    while ($queue_idx < ($queue|count)) {
      each {
        var $current {
          value = $queue[$queue_idx]
        }
        var.update $queue_idx {
          value = $queue_idx + 1
        }
        
        conditional {
          if ($current == null) {
            var $null_val {
              value = "null"
            }
            var $updated_serial {
              value = $serialized_values|merge:[$null_val]
            }
            var.update $serialized_values {
              value = $updated_serial
            }
          }
          else {
            // Add node value
            var $node_val {
              value = $current.val|to_text
            }
            var $updated_serial2 {
              value = $serialized_values|merge:[$node_val]
            }
            var.update $serialized_values {
              value = $updated_serial2
            }
            
            // Add children to queue (even if null)
            var $left_child {
              value = $current.left
            }
            var $right_child {
              value = $current.right
            }
            var $extended_queue {
              value = $queue|merge:[$left_child, $right_child]
            }
            var.update $queue {
              value = $extended_queue
            }
          }
        }
      }
    }
    
    // Trim trailing nulls
    var $trimmed_values {
      value = $serialized_values
    }
    
    var $last_idx {
      value = ($trimmed_values|count) - 1
    }
    
    var $continue_trimming {
      value = true
    }
    
    conditional {
      if ($last_idx < 0) {
        var.update $continue_trimming {
          value = false
        }
      }
    }
    
    while ($continue_trimming) {
      each {
        var $last_val {
          value = $trimmed_values[$last_idx]
        }
        conditional {
          if ($last_val == "null") {
            // Remove trailing null
            var $new_trimmed {
              value = $trimmed_values|slice:0:$last_idx
            }
            var.update $trimmed_values {
              value = $new_trimmed
            }
            var.update $last_idx {
              value = $last_idx - 1
            }
            conditional {
              if ($last_idx < 0) {
                var.update $continue_trimming {
                  value = false
                }
              }
            }
          }
          else {
            // Found non-null, stop trimming
            var.update $continue_trimming {
              value = false
            }
          }
        }
      }
    }
    
    // Build serialized string
    var $serialized {
      value = ""
    }
    conditional {
      if (($trimmed_values|count) > 0) {
        var $joined {
          value = $trimmed_values|join:","
        }
        var.update $serialized {
          value = $joined
        }
      }
      else {
        var.update $serialized {
          value = ""
        }
      }
    }
    
    // Deserialize: rebuild tree from serialized string
    var $deserialized_root {
      value = null
    }
    
    conditional {
      if ($serialized != "") {
        var $tokens {
          value = $serialized|split:","
        }
        var $num_tokens {
          value = $tokens|count
        }
        
        conditional {
          if ($num_tokens > 0) {
            // Create array of node objects
            var $nodes {
              value = []
            }
            
            var $i {
              value = 0
            }
            while ($i < $num_tokens) {
              each {
                var $token {
                  value = $tokens[$i]
                }
                conditional {
                  if ($token == "null") {
                    var $null_node {
                      value = null
                    }
                    var $nodes_with_null {
                      value = $nodes|merge:[$null_node]
                    }
                    var.update $nodes {
                      value = $nodes_with_null
                    }
                  }
                  else {
                    var $val_int {
                      value = $token|to_int
                    }
                    var $new_node {
                      value = { val: $val_int, left: null, right: null }
                    }
                    var $nodes_with_new {
                      value = $nodes|merge:[$new_node]
                    }
                    var.update $nodes {
                      value = $nodes_with_new
                    }
                  }
                }
                var.update $i {
                  value = $i + 1
                }
              }
            }
            
            // Set root
            var.update $deserialized_root {
              value = $nodes[0]
            }
            
            // Link children using BFS index pattern
            // For node at index i: left child is at 2*i+1, right at 2*i+2
            var $parent_idx {
              value = 0
            }
            var $child_idx {
              value = 1
            }
            
            while ($parent_idx < $num_tokens) {
              each {
                var $parent_node {
                  value = $nodes[$parent_idx]
                }
                
                conditional {
                  if ($parent_node != null) {
                    // Set left child
                    conditional {
                      if ($child_idx < $num_tokens) {
                        var $left_node {
                          value = $nodes[$child_idx]
                        }
                        var $parent_with_left {
                          value = { val: $parent_node.val, left: $left_node, right: $parent_node.right }
                        }
                        // Update parent in nodes array
                        var $before_left {
                          value = $nodes|slice:0:$parent_idx
                        }
                        var $after_left {
                          value = $nodes|slice:($parent_idx + 1)
                        }
                        var $nodes_with_left {
                          value = $before_left|merge:[$parent_with_left]|merge:$after_left
                        }
                        var.update $nodes {
                          value = $nodes_with_left
                        }
                        
                        // Update deserialized_root if this was root
                        conditional {
                          if ($parent_idx == 0) {
                            var.update $deserialized_root {
                              value = $parent_with_left
                            }
                          }
                        }
                        
                        // Update parent_node reference
                        var.update $parent_node {
                          value = $parent_with_left
                        }
                      }
                    }
                    
                    // Set right child
                    conditional {
                      if (($child_idx + 1) < $num_tokens) {
                        var $right_node {
                          value = $nodes[$child_idx + 1]
                        }
                        var $parent_with_right {
                          value = { val: $parent_node.val, left: $parent_node.left, right: $right_node }
                        }
                        // Update parent in nodes array
                        var $before_right {
                          value = $nodes|slice:0:$parent_idx
                        }
                        var $after_right {
                          value = $nodes|slice:($parent_idx + 1)
                        }
                        var $nodes_with_right {
                          value = $before_right|merge:[$parent_with_right]|merge:$after_right
                        }
                        var.update $nodes {
                          value = $nodes_with_right
                        }
                        
                        // Update deserialized_root if this was root
                        conditional {
                          if ($parent_idx == 0) {
                            var.update $deserialized_root {
                              value = $parent_with_right
                            }
                          }
                        }
                      }
                    }
                  }
                }
                
                var.update $parent_idx {
                  value = $parent_idx + 1
                }
                var.update $child_idx {
                  value = $child_idx + 2
                }
              }
            }
          }
        }
      }
    }
  }
  response = {
    original: $input.tree,
    serialized: $serialized,
    deserialized: $deserialized_root
  }
}