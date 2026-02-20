// Linked List Reversal - Classic coding interview question
// Reverses a singly linked list and returns the new head
function "reverse_linked_list" {
  description = "Reverses a singly linked list"
  
  input {
    json list
    int? head_index?=0
  }
  
  stack {
    // Handle edge cases
    conditional {
      if (($input.list|count) == 0) {
        return { value = { nodes: [], head_index: null } }
      }
      elseif ($input.head_index == null) {
        return { value = { nodes: $input.list, head_index: null } }
      }
    }
    
    // Initialize pointers for reversal
    var $prev { value = null }
    var $current { value = $input.head_index }
    
    // Create a copy of the list to modify
    var $nodes { value = $input.list }
    
    // Traverse and reverse links
    while ($current != null) {
      each {
        // Get the next node before we change the link
        var $next_node { value = $nodes[$current]|get:"next" }
        
        // Reverse the link - point current node's next to prev
        var $updated_node { 
          value = $nodes[$current]|set:"next":$prev 
        }
        var $nodes { 
          value = $nodes|set:$current:$updated_node 
        }
        
        // Move pointers forward
        var $prev { value = $current }
        var $current { value = $next_node }
      }
    }
    
    // prev is now the new head
    var $new_head { value = $prev }
  }
  
  response = { nodes: $nodes, head_index: $new_head }
}
