// Merge Two Sorted Lists - Classic coding interview question
// Merges two sorted linked lists into a single sorted linked list
function "merge_two_sorted_lists" {
  description = "Merges two sorted linked lists into one sorted linked list"
  
  input {
    json list1
    int? head1?
    json list2
    int? head2?
  }
  
  stack {
    // Handle edge cases - if list1 is empty, return list2
    conditional {
      if (($input.list1|count) == 0 || $input.head1 == null) {
        return { value = { nodes: $input.list2, head_index: $input.head2 } }
      }
    }
    
    // Handle edge cases - if list2 is empty, return list1
    conditional {
      if (($input.list2|count) == 0 || $input.head2 == null) {
        return { value = { nodes: $input.list1, head_index: $input.head1 } }
      }
    }
    
    // Initialize pointers for both lists
    var $p1 { value = $input.head1 }
    var $p2 { value = $input.head2 }
    
    // Create a dummy head node for the merged list
    var $dummy { value = { value: 0, next: null } }
    var $current { value = $dummy }
    var $merged_nodes { value = [$dummy] }
    var $tail_index { value = 0 }
    
    // Merge the two lists
    while ($p1 != null && $p2 != null) {
      each {
        var $val1 { value = $input.list1[$p1]|get:"value" }
        var $val2 { value = $input.list2[$p2]|get:"value" }
        
        conditional {
          if ($val1 <= $val2) {
            // Take from list1
            var $new_node { 
              value = { 
                value: $val1, 
                next: null 
              } 
            }
            var $merged_nodes { 
              value = $merged_nodes|append:$new_node 
            }
            var $tail_index { value = $tail_index + 1 }
            
            // Update the next pointer of the previous node
            var $prev_node { 
              value = $merged_nodes[$tail_index - 1]|set:"next":$tail_index 
            }
            var $merged_nodes { 
              value = $merged_nodes|set:($tail_index - 1):$prev_node 
            }
            
            // Move p1 forward
            var $p1 { 
              value = $input.list1[$p1]|get:"next" 
            }
          }
          else {
            // Take from list2
            var $new_node { 
              value = { 
                value: $val2, 
                next: null 
              } 
            }
            var $merged_nodes { 
              value = $merged_nodes|append:$new_node 
            }
            var $tail_index { value = $tail_index + 1 }
            
            // Update the next pointer of the previous node
            var $prev_node { 
              value = $merged_nodes[$tail_index - 1]|set:"next":$tail_index 
            }
            var $merged_nodes { 
              value = $merged_nodes|set:($tail_index - 1):$prev_node 
            }
            
            // Move p2 forward
            var $p2 { 
              value = $input.list2[$p2]|get:"next" 
            }
          }
        }
      }
    }
    
    // Append remaining nodes from list1
    while ($p1 != null) {
      each {
        var $val1 { value = $input.list1[$p1]|get:"value" }
        var $new_node { 
          value = { 
            value: $val1, 
            next: null 
          } 
        }
        var $merged_nodes { 
          value = $merged_nodes|append:$new_node 
        }
        var $tail_index { value = $tail_index + 1 }
        
        // Update the next pointer of the previous node
        var $prev_node { 
          value = $merged_nodes[$tail_index - 1]|set:"next":$tail_index 
        }
        var $merged_nodes { 
          value = $merged_nodes|set:($tail_index - 1):$prev_node 
        }
        
        // Move p1 forward
        var $p1 { 
          value = $input.list1[$p1]|get:"next" 
        }
      }
    }
    
    // Append remaining nodes from list2
    while ($p2 != null) {
      each {
        var $val2 { value = $input.list2[$p2]|get:"value" }
        var $new_node { 
          value = { 
            value: $val2, 
            next: null 
          } 
        }
        var $merged_nodes { 
          value = $merged_nodes|append:$new_node 
        }
        var $tail_index { value = $tail_index + 1 }
        
        // Update the next pointer of the previous node
        var $prev_node { 
          value = $merged_nodes[$tail_index - 1]|set:"next":$tail_index 
        }
        var $merged_nodes { 
          value = $merged_nodes|set:($tail_index - 1):$prev_node 
        }
        
        // Move p2 forward
        var $p2 { 
          value = $input.list2[$p2]|get:"next" 
        }
      }
    }
    
    // The merged list starts at index 1 (skip dummy node)
    var $result_head { value = 1 }
    var $result_nodes { value = $merged_nodes|slice:1 }
    
    // Adjust indices in the result - subtract 1 from all next pointers
    var $adjusted_nodes { value = [] }
    foreach ($result_nodes) {
      each as $node {
        var $next_idx { value = $node|get:"next" }
        conditional {
          if ($next_idx != null) {
            var $adjusted_node { 
              value = $node|set:"next":($next_idx - 1) 
            }
          }
          else {
            var $adjusted_node { value = $node }
          }
        }
        var $adjusted_nodes { 
          value = $adjusted_nodes|append:$adjusted_node 
        }
      }
    }
  }
  
  response = { nodes: $adjusted_nodes, head_index: 0 }
}