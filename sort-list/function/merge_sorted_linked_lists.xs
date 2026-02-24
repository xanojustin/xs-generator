// Merge two sorted linked lists into a single sorted linked list
// Takes two sorted linked lists and returns a new sorted list containing all nodes
function "merge_sorted_linked_lists" {
  description = "Merges two sorted linked lists into one sorted list"
  
  input {
    json nodes { description = "Array of node objects containing both lists" }
    int? head1 { description = "Head index of first sorted list (null if empty)" }
    int? head2 { description = "Head index of second sorted list (null if empty)" }
  }
  
  stack {
    // Handle edge cases
    conditional {
      if ($input.head1 == null) {
        var $result { 
          value = { nodes: $input.nodes, head_index: $input.head2 } 
        }
      }
      elseif ($input.head2 == null) {
        var $result { 
          value = { nodes: $input.nodes, head_index: $input.head1 } 
        }
      }
      else {
        // Both lists are non-empty, merge them
        var $p1 { value = $input.head1 }
        var $p2 { value = $input.head2 }
        
        // Determine the new head
        var $node1 { value = $input.nodes[$p1] }
        var $node2 { value = $input.nodes[$p2] }
        var $val1 { value = $node1|get:"value" }
        var $val2 { value = $node2|get:"value" }
        
        var $new_head { value = 0 }
        var $merged_nodes { value = [] }
        var $tail_idx { value = 0 }
        
        conditional {
          if ($val1 <= $val2) {
            var $merged_nodes { 
              value = [{ value: $val1, next: null }] 
            }
            var $p1 { 
              value = $node1|get:"next" 
            }
          }
          else {
            var $merged_nodes { 
              value = [{ value: $val2, next: null }] 
            }
            var $p2 { 
              value = $node2|get:"next" 
            }
          }
        }
        
        // Merge remaining nodes
        while ($p1 != null || $p2 != null) {
          each {
            conditional {
              if ($p1 == null) {
                // Only list2 has remaining nodes
                var $n2 { value = $input.nodes[$p2] }
                var $v2 { value = $n2|get:"value" }
                var $new_node { 
                  value = { value: $v2, next: null } 
                }
                var $merged_nodes { 
                  value = $merged_nodes|append:$new_node 
                }
                // Update previous node's next pointer
                var $prev_node { 
                  value = $merged_nodes[$tail_idx]|set:"next":($tail_idx + 1) 
                }
                var $merged_nodes { 
                  value = $merged_nodes|set:$tail_idx:$prev_node 
                }
                var $tail_idx { value = $tail_idx + 1 }
                var $p2 { 
                  value = $n2|get:"next" 
                }
              }
              elseif ($p2 == null) {
                // Only list1 has remaining nodes
                var $n1 { value = $input.nodes[$p1] }
                var $v1 { value = $n1|get:"value" }
                var $new_node { 
                  value = { value: $v1, next: null } 
                }
                var $merged_nodes { 
                  value = $merged_nodes|append:$new_node 
                }
                // Update previous node's next pointer
                var $prev_node { 
                  value = $merged_nodes[$tail_idx]|set:"next":($tail_idx + 1) 
                }
                var $merged_nodes { 
                  value = $merged_nodes|set:$tail_idx:$prev_node 
                }
                var $tail_idx { value = $tail_idx + 1 }
                var $p1 { 
                  value = $n1|get:"next" 
                }
              }
              else {
                // Both lists have nodes, compare values
                var $n1 { value = $input.nodes[$p1] }
                var $n2 { value = $input.nodes[$p2] }
                var $v1 { value = $n1|get:"value" }
                var $v2 { value = $n2|get:"value" }
                
                conditional {
                  if ($v1 <= $v2) {
                    var $new_node { 
                      value = { value: $v1, next: null } 
                    }
                    var $merged_nodes { 
                      value = $merged_nodes|append:$new_node 
                    }
                    var $prev_node { 
                      value = $merged_nodes[$tail_idx]|set:"next":($tail_idx + 1) 
                    }
                    var $merged_nodes { 
                      value = $merged_nodes|set:$tail_idx:$prev_node 
                    }
                    var $tail_idx { value = $tail_idx + 1 }
                    var $p1 { 
                      value = $n1|get:"next" 
                    }
                  }
                  else {
                    var $new_node { 
                      value = { value: $v2, next: null } 
                    }
                    var $merged_nodes { 
                      value = $merged_nodes|append:$new_node 
                    }
                    var $prev_node { 
                      value = $merged_nodes[$tail_idx]|set:"next":($tail_idx + 1) 
                    }
                    var $merged_nodes { 
                      value = $merged_nodes|set:$tail_idx:$prev_node 
                    }
                    var $tail_idx { value = $tail_idx + 1 }
                    var $p2 { 
                      value = $n2|get:"next" 
                    }
                  }
                }
              }
            }
          }
        }
        
        var $result { 
          value = { nodes: $merged_nodes, head_index: 0 } 
        }
      }
    }
  }
  
  response = $result
}
