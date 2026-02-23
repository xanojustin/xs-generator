// Remove Nth Node From End of List - Classic coding interview question
// Given the head of a linked list, remove the nth node from the end and return the modified list
function "remove_nth_node_from_end" {
  description = "Removes the nth node from the end of a linked list"
  
  input {
    json nodes
    int? head
    int n
  }
  
  stack {
    // Handle edge cases
    conditional {
      if (($input.nodes|count) == 0 || $input.head == null) {
        return { value = { nodes: $input.nodes, head: null } }
      }
    }
    
    // Create a dummy node to handle edge case of removing the head
    var $dummy { 
      value = { value: 0, next: $input.head } 
    }
    
    // Initialize two pointers - both start at dummy
    var $fast { value = $dummy }
    var $slow { value = $dummy }
    
    // Move fast pointer n+1 steps ahead (so slow will be at node before target)
    var $fast_index { value = $input.head }
    var $steps { value = 0 }
    
    while ($steps < $input.n && $fast_index != null) {
      each {
        var $fast { value = $input.nodes[$fast_index] }
        var $fast_index { value = $fast|get:"next" }
        var $steps { value = $steps + 1 }
      }
    }
    
    // If fast reached null before n steps, n is larger than list length
    conditional {
      if ($steps < $input.n) {
        // n is larger than list length, return original list
        return { value = { nodes: $input.nodes, head: $input.head } }
      }
    }
    
    // Now move both pointers until fast reaches the end
    // Slow will be at the node before the one to remove
    var $slow_index { value = $input.head }
    var $prev_index { value = null }
    
    // We need to track where slow pointer should be
    // After moving fast n steps, we need to find where slow ends up
    var $target_index { value = $input.head }
    var $target_steps { value = 0 }
    
    // Calculate position of node to remove (from beginning)
    var $length { value = 0 }
    var $temp_idx { value = $input.head }
    while ($temp_idx != null) {
      each {
        var $length { value = $length + 1 }
        var $temp { value = $input.nodes[$temp_idx] }
        var $temp_idx { value = $temp|get:"next" }
      }
    }
    
    // Position from start (0-indexed) = length - n
    var $remove_pos { value = $length - $input.n }
    
    // Handle removing the head
    conditional {
      if ($remove_pos == 0) {
        var $head_node { value = $input.nodes[$input.head] }
        var $new_head { value = $head_node|get:"next" }
        
        // Create new nodes array without the head
        var $new_nodes { value = [] }
        var $idx { value = $input.head }
        var $skip_first { value = true }
        
        while ($idx != null) {
          each {
            var $node { value = $input.nodes[$idx] }
            conditional {
              if (!$skip_first) {
                var $new_nodes { value = $new_nodes|append:$node }
              }
            }
            var $skip_first { value = false }
            var $idx { value = $node|get:"next" }
          }
        }
        
        // Adjust indices in new nodes
        var $adjusted_nodes { value = [] }
        var $i { value = 0 }
        foreach ($new_nodes) {
          each as $node {
            var $next { value = $node|get:"next" }
            conditional {
              if ($next != null) {
                var $adjusted_next { value = $next - 1 }
                var $adjusted_node { value = $node|set:"next":$adjusted_next }
              }
              else {
                var $adjusted_node { value = $node }
              }
            }
            var $adjusted_nodes { value = $adjusted_nodes|append:$adjusted_node }
          }
        }
        
        var $new_head_idx { 
          value = ($new_nodes|count) > 0 ? 0 : null 
        }
        return { value = { nodes: $adjusted_nodes, head: $new_head_idx } }
      }
    }
    
    // Find the node before the one to remove
    var $prev_pos { value = 0 }
    var $prev_idx { value = $input.head }
    var $current_idx { value = $input.head }
    
    while ($prev_pos < ($remove_pos - 1)) {
      each {
        var $current { value = $input.nodes[$current_idx] }
        var $current_idx { value = $current|get:"next" }
        var $prev_pos { value = $prev_pos + 1 }
      }
    }
    
    var $prev_node { value = $input.nodes[$current_idx] }
    var $remove_idx { value = $prev_node|get:"next" }
    var $remove_node { value = $input.nodes[$remove_idx] }
    var $next_after_remove { value = $remove_node|get:"next" }
    
    // Build new nodes array, skipping the node to remove
    var $new_nodes { value = [] }
    var $idx { value = $input.head }
    var $pos { value = 0 }
    
    while ($idx != null) {
      each {
        conditional {
          if ($pos != $remove_pos) {
            var $node { value = $input.nodes[$idx] }
            var $next { value = $node|get:"next" }
            
            // Adjust next pointer if it points to or past removed node
            conditional {
              if ($next != null && $next > $remove_idx) {
                var $adjusted_node { value = $node|set:"next":($next - 1) }
              }
              elseif ($next == $remove_idx) {
                var $adjusted_node { value = $node|set:"next":$next_after_remove } 
                conditional {
                  if ($next_after_remove != null && $next_after_remove > $remove_idx) {
                    var $adjusted_node { 
                      value = $adjusted_node|set:"next":($next_after_remove - 1) 
                    }
                  }
                }
              }
              else {
                var $adjusted_node { value = $node }
              }
            }
            var $new_nodes { value = $new_nodes|append:$adjusted_node }
          }
        }
        
        var $idx { 
          value = $input.nodes[$idx]|get:"next" 
        }
        var $pos { value = $pos + 1 }
      }
    }
    
    // Adjust all next pointers since array indices changed
    var $final_nodes { value = [] }
    var $i { value = 0 }
    foreach ($new_nodes) {
      each as $node {
        var $next { value = $node|get:"next" }
        conditional {
          if ($next != null && $next > $remove_idx) {
            var $adjusted_node { value = $node|set:"next":($next - 1) }
          }
          else {
            var $adjusted_node { value = $node }
          }
        }
        var $final_nodes { value = $final_nodes|append:$adjusted_node }
      }
    }
  }
  
  response = { nodes: $final_nodes, head: 0 }
}