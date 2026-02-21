// Balanced Binary Tree - Check if a binary tree is height-balanced
// A tree is height-balanced if the left and right subtrees of every node
// differ in height by no more than 1
function "is_balanced" {
  description = "Determines if a binary tree is height-balanced"

  input {
    json root { description = "Root node of the binary tree with val, left, and right properties" }
  }

  stack {
    // Use iterative post-order traversal with a visited flag
    // Stack entries: { node: json, visited: bool }
    var $stack {
      value = []
    }

    // Initialize with root node if it exists
    conditional {
      if ($input.root != null) {
        var $stack {
          value = [
            {
              node: $input.root,
              visited: false
            }
          ]
        }
      }
    }

    // Map to store height of processed nodes using a counter-based ID
    // We'll use the node's position in traversal as its ID
    var $heights {
      value = []
    }

    // Map node values to their heights (assuming unique values for simplicity in this exercise)
    // In a real scenario with duplicate values, we'd need a different approach
    var $node_heights {
      value = {}
    }

    var $is_balanced {
      value = true
    }

    // Process stack while there are nodes and tree is still balanced
    while (($stack|count) > 0 && $is_balanced) {
      each {
        // Pop from stack
        var $current {
          value = $stack|last
        }
        var $stack {
          value = $stack|slice:0:-1
        }

        var $node {
          value = $current.node
        }
        var $visited {
          value = $current.visited
        }

        conditional {
          // If node is null, skip
          if ($node == null) {
            // Do nothing, continue
          }
          // If already visited, calculate height
          elseif ($visited) {
            // Get left and right heights (0 if null)
            var $left_height {
              value = 0
            }
            var $right_height {
              value = 0
            }

            conditional {
              if ($node.left != null) {
                var $left_key {
                  value = "node_" ~ ($node.left.val|to_text)
                }
                var $left_height {
                  value = $node_heights|get:($left_key):0
                }
              }
            }

            conditional {
              if ($node.right != null) {
                var $right_key {
                  value = "node_" ~ ($node.right.val|to_text)
                }
                var $right_height {
                  value = $node_heights|get:($right_key):0
                }
              }
            }

            // Check balance condition
            var $height_diff {
              value = $left_height - $right_height
            }
            conditional {
              if ($height_diff < 0) {
                var $height_diff {
                  value = 0 - $height_diff
                }
              }
            }

            conditional {
              if ($height_diff > 1) {
                var $is_balanced {
                  value = false
                }
              }
              else {
                // Store height for this node using its value as key
                var $current_key {
                  value = "node_" ~ ($node.val|to_text)
                }
                var $current_height {
                  value = $left_height
                }
                conditional {
                  if ($right_height > $left_height) {
                    var $current_height {
                      value = $right_height
                    }
                  }
                }
                var $current_height {
                  value = $current_height + 1
                }
                var $node_heights {
                  value = $node_heights|set:($current_key):$current_height
                }
              }
            }
          }
          // First visit - push back as visited, then push children
          else {
            var $stack {
              value = $stack|merge:[
                {
                  node: $node,
                  visited: true
                }
              ]
            }

            // Push right first (so left is processed first - LIFO)
            conditional {
              if ($node.right != null) {
                var $stack {
                  value = $stack|merge:[
                    {
                      node: $node.right,
                      visited: false
                    }
                  ]
                }
              }
            }

            conditional {
              if ($node.left != null) {
                var $stack {
                  value = $stack|merge:[
                    {
                      node: $node.left,
                      visited: false
                    }
                  ]
                }
              }
            }
          }
        }
      }
    }

    var $result {
      value = $is_balanced
    }
  }

  response = $result
}
