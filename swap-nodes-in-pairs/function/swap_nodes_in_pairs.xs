// Swap Nodes in Pairs - Classic coding interview question
// Swaps every two adjacent nodes in a linked list
function "swap_nodes_in_pairs" {
  description = "Swaps every two adjacent nodes in a linked list"
  
  input {
    json list
    int? head_index?=0
  }
  
  stack {
    // Handle edge cases
    conditional {
      // Empty list or single node - nothing to swap
      if (($input.list|count) < 2 || $input.head_index == null) {
        return { value = { nodes: $input.list, head_index: $input.head_index } }
      }
    }
    
    // Create a copy of the list to modify
    var $nodes { value = $input.list }
    
    // Dummy node to simplify head swapping
    // We'll use index -1 conceptually, but track new_head separately
    var $new_head { value = $input.head_index }
    
    // Track the previous pair's tail (initially null)
    var $prev_tail { value = null }
    
    // Current position in the list
    var $current { value = $input.head_index }
    
    // Process pairs
    while ($current != null) {
      each {
        // Get first and second nodes of the pair
        var $first { value = $current }
        var $second { value = $nodes[$current]|get:"next" }
        
        // If there's no second node, we're done (odd number of nodes)
        conditional {
          if ($second == null) {
            var $current { value = null }
          }
          else {
            // Get the node after the pair (could be null)
            var $next_pair { value = $nodes[$second]|get:"next" }
            
            // Swap the pair: second -> first -> next_pair
            var $first_node { value = $nodes[$first] }
            var $second_node { value = $nodes[$second] }
            
            // Point second's next to first
            var $updated_second { 
              value = $second_node|set:"next":$first 
            }
            var $nodes { 
              value = $nodes|set:$second:$updated_second 
            }
            
            // Point first's next to next_pair
            var $updated_first { 
              value = $first_node|set:"next":$next_pair 
            }
            var $nodes { 
              value = $nodes|set:$first:$updated_first 
            }
            
            // If this is the first pair, update new_head
            conditional {
              if ($prev_tail == null) {
                var $new_head { value = $second }
              }
              else {
                // Connect previous pair's tail to this pair's new head (second)
                var $prev_tail_node { value = $nodes[$prev_tail] }
                var $updated_prev_tail { 
                  value = $prev_tail_node|set:"next":$second 
                }
                var $nodes { 
                  value = $nodes|set:$prev_tail:$updated_prev_tail 
                }
              }
            }
            
            // Move to next pair
            var $prev_tail { value = $first }
            var $current { value = $next_pair }
          }
        }
      }
    }
  }
  
  response = { nodes: $nodes, head_index: $new_head }
}
