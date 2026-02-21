function "implement_trie" {
  description = "Implement a Trie (Prefix Tree) data structure with insert, search, and startsWith operations"
  input {
    text[] operations
    json[] inputs
  }
  stack {
    // Initialize the trie as an empty object
    // Each node will be an object with:
    // - children: object mapping characters to child nodes
    // - is_end: boolean indicating if this node marks the end of a word
    var $trie_root {
      value = {
        children: {},
        is_end: false
      }
    }
    
    // Results array to store output of each operation
    var $results {
      value = []
    }
    
    // Iterate through all operations
    var $i {
      value = 0
    }
    while ($i < ($input.operations|count)) {
      each {
        // Get current operation and input
        var $op {
          value = $input.operations[$i]
        }
        var $current_input {
          value = $input.inputs[$i]
        }
        
        // Handle insert operation
        conditional {
          if ($op == "insert") {
            var $word {
              value = $current_input.word
            }
            var $current_node {
              value = $trie_root
            }
            
            // Insert each character of the word
            var $j {
              value = 0
            }
            while ($j < ($word|strlen)) {
              each {
                var $char {
                  value = $word|substr:$j:1
                }
                
                // Check if character exists in children
                var $children {
                  value = $current_node.children
                }
                var $has_child {
                  value = ($children|get:$char) != null
                }
                
                conditional {
                  if (!$has_child) {
                    // Create new node for this character
                    var $new_node {
                      value = {
                        children: {},
                        is_end: false
                      }
                    }
                    var $updated_children {
                      value = $children|set:$char:$new_node
                    }
                    var.update $current_node.children {
                      value = $updated_children
                    }
                  }
                }
                
                // Move to child node
                var $next_node {
                  value = $current_node.children|get:$char
                }
                var.update $current_node {
                  value = $next_node
                }
                
                math.add $j {
                  value = 1
                }
              }
            }
            
            // Mark end of word
            var.update $current_node.is_end {
              value = true
            }
            
            // Insert returns null
            var $null_result {
              value = null
            }
            var $new_results {
              value = $results|set:(($results|count)):$null_result
            }
            var.update $results {
              value = $new_results
            }
          }
          elseif ($op == "search") {
            var $search_word {
              value = $current_input.word
            }
            var $search_node {
              value = $trie_root
            }
            var $found {
              value = true
            }
            
            // Traverse to find the word
            var $k {
              value = 0
            }
            while ($k < ($search_word|strlen)) {
              each {
                var $search_char {
                  value = $search_word|substr:$k:1
                }
                var $search_children {
                  value = $search_node.children
                }
                var $child_exists {
                  value = ($search_children|get:$search_char) != null
                }
                
                conditional {
                  if (!$child_exists) {
                    var.update $found {
                      value = false
                    }
                    // Break out - set k to max to exit loop
                    var $remaining {
                      value = ($search_word|strlen) + 1
                    }
                    var.update $k {
                      value = $remaining
                    }
                  }
                  else {
                    // Move to child
                    var $next_search_node {
                      value = $search_node.children|get:$search_char
                    }
                    var.update $search_node {
                      value = $next_search_node
                    }
                    math.add $k {
                      value = 1
                    }
                  }
                }
              }
            }
            
            // Check if we found a complete word
            conditional {
              if ($found) {
                var.update $found {
                  value = $search_node.is_end
                }
              }
            }
            
            var $search_results {
              value = $results|set:(($results|count)):$found
            }
            var.update $results {
              value = $search_results
            }
          }
          elseif ($op == "startsWith") {
            var $prefix {
              value = $current_input.prefix
            }
            var $prefix_node {
              value = $trie_root
            }
            var $prefix_found {
              value = true
            }
            
            // Traverse to find the prefix
            var $m {
              value = 0
            }
            while ($m < ($prefix|strlen)) {
              each {
                var $prefix_char {
                  value = $prefix|substr:$m:1
                }
                var $prefix_children {
                  value = $prefix_node.children
                }
                var $prefix_child_exists {
                  value = ($prefix_children|get:$prefix_char) != null
                }
                
                conditional {
                  if (!$prefix_child_exists) {
                    var.update $prefix_found {
                      value = false
                    }
                    // Break out - set m to max to exit loop
                    var $prefix_remaining {
                      value = ($prefix|strlen) + 1
                    }
                    var.update $m {
                      value = $prefix_remaining
                    }
                  }
                  else {
                    // Move to child
                    var $next_prefix_node {
                      value = $prefix_node.children|get:$prefix_char
                    }
                    var.update $prefix_node {
                      value = $next_prefix_node
                    }
                    math.add $m {
                      value = 1
                    }
                  }
                }
              }
            }
            
            var $prefix_results {
              value = $results|set:(($results|count)):$prefix_found
            }
            var.update $results {
              value = $prefix_results
            }
          }
        }
        
        math.add $i {
          value = 1
        }
      }
    }
  }
  response = $results
}