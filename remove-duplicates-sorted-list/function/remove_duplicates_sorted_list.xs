// Remove Duplicates from Sorted List - Classic coding interview question
// Given a sorted linked list, delete all duplicates so each element appears only once
function "remove_duplicates_sorted_list" {
  description = "Removes duplicate nodes from a sorted linked list"
  
  input {
    json list
    int? head_index?=0
  }
  
  stack {
    // Handle edge cases: empty list or single node
    conditional {
      if (($input.list|count) == 0) {
        return { value = { nodes: [], head_index: null } }
      }
      elseif (($input.list|count) == 1) {
        return { value = { nodes: $input.list, head_index: 0 } }
      }
      elseif ($input.head_index == null) {
        return { value = { nodes: $input.list, head_index: null } }
      }
    }
    
    // Create a copy of the list to modify
    var $nodes { value = $input.list }
    var $current { value = $input.head_index }
    
    // Traverse the list and remove duplicates
    while ($current != null) {
      each {
        // Get current node and its value
        var $current_node { value = $nodes[$current] }
        var $current_value { value = $current_node|get:"value" }
        var $next_index { value = $current_node|get:"next" }
        
        // Check if next node exists and has the same value
        conditional {
          if ($next_index != null) {
            var $next_node { value = $nodes[$next_index] }
            var $next_value { value = $next_node|get:"value" }
            
            conditional {
              // If duplicate, skip the next node
              if ($current_value == $next_value) {
                var $next_next { value = $next_node|get:"next" }
                var $updated_current { 
                  value = $current_node|set:"next":$next_next 
                }
                var $nodes { 
                  value = $nodes|set:$current:$updated_current 
                }
                // Don't advance current - check next again for more duplicates
              }
              else {
                // No duplicate, move to next node
                var $current { value = $next_index }
              }
            }
          }
          else {
            // No next node, we're done
            var $current { value = null }
          }
        }
      }
    }
  }
  
  response = { nodes: $nodes, head_index: $input.head_index }
}
