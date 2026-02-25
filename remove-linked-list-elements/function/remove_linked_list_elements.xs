// Remove Linked List Elements - Classic coding interview question
// Remove all elements from a linked list of integers that have value val
function "remove_linked_list_elements" {
  description = "Removes all nodes with the specified value from a linked list"
  
  input {
    json nodes
    int? head
    int val
  }
  
  stack {
    // Handle empty list
    conditional {
      if (($input.nodes|count) == 0 || $input.head == null) {
        return { value = { nodes: [], head: null } }
      }
    }
    
    // First pass: identify which nodes to keep
    var $keep_indices { value = [] }
    var $idx { value = $input.head }
    
    while ($idx != null) {
      each {
        var $node { value = $input.nodes[$idx] }
        var $node_val { value = $node|get:"value" }
        var $next_idx { value = $node|get:"next" }
        
        conditional {
          if ($node_val != $input.val) {
            var $keep_indices { value = $keep_indices|append:$idx }
          }
        }
        
        var $idx { value = $next_idx }
      }
    }
    
    // If no nodes to keep, return empty list
    conditional {
      if (($keep_indices|count) == 0) {
        return { value = { nodes: [], head: null } }
      }
    }
    
    // Build new nodes array with kept nodes and adjusted next pointers
    var $new_nodes { value = [] }
    var $i { value = 0 }
    
    while ($i < ($keep_indices|count)) {
      each {
        var $old_idx { value = $keep_indices[$i] }
        var $old_node { value = $input.nodes[$old_idx] }
        var $old_val { value = $old_node|get:"value" }
        var $old_next { value = $old_node|get:"next" }
        
        // Find if old_next is in keep_indices
        var $new_next { value = null }
        var $found_next { value = false }
        var $j { value = $i + 1 }
        
        conditional {
          if ($j < ($keep_indices|count)) {
            var $next_old_idx { value = $keep_indices[$j] }
            var $new_next { value = $j }
            var $found_next { value = true }
          }
        }
        
        // Create new node
        var $new_node { value = { value: $old_val, next: $new_next } }
        var $new_nodes { value = $new_nodes|append:$new_node }
        
        var $i { value = $i + 1 }
      }
    }
    
    var $new_head { value = 0 }
  }
  
  response = { nodes: $new_nodes, head: $new_head }
}
