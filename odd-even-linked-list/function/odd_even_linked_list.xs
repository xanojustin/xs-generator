// Odd Even Linked List - Classic coding interview question
// Groups all odd-positioned nodes together followed by even-positioned nodes
// First node is odd (position 1), second is even (position 2), etc.
function "odd_even_linked_list" {
  description = "Reorders linked list so odd-positioned nodes come before even-positioned nodes"

  input {
    json nodes
    int head_index
  }

  stack {
    // Handle edge cases: empty list or single node (already valid)
    conditional {
      if (($input.nodes|count) == 0 || ($input.nodes|count) == 1) {
        return { value = { nodes: $input.nodes, head_index: $input.head_index } }
      }
    }

    // Create a working copy of nodes that we can modify
    var $nodes { value = $input.nodes }
    
    // Initialize pointers for odd and even lists
    var $odd_head { value = $input.head_index }
    var $even_head { value = null }
    var $odd_tail { value = $odd_head }
    var $even_tail { value = null }
    
    // Track current position (1-indexed: 1=odd, 2=even, etc.)
    var $position { value = 2 }
    
    // Get first node's next to start traversal
    var $first_node { value = $nodes[$odd_head] }
    var $current_idx { value = $first_node|get:"next" }
    
    // Separate nodes into odd and even lists
    while ($current_idx != null) {
      each {
        var $current_node { value = $nodes[$current_idx] }
        var $next_idx { value = $current_node|get:"next" }
        
        conditional {
          // Odd position: add to odd list
          if ($position % 2 == 1) {
            conditional {
              if ($odd_tail == $odd_head) {
                // First odd node after head - set as odd_head's next
                var $updated_node { value = $nodes[$odd_head]|set:"next":$current_idx }
                var $nodes { value = $nodes|set:$odd_head:$updated_node }
              }
              else {
                // Link previous odd node to current
                var $prev_node { value = $nodes[$odd_tail] }
                var $linked { value = $prev_node|set:"next":$current_idx }
                var $nodes { value = $nodes|set:$odd_tail:$linked }
              }
            }
            var $odd_tail { value = $current_idx }
          }
          // Even position: add to even list
          else {
            conditional {
              if ($even_head == null) {
                // First even node - set as even_head
                var $even_head { value = $current_idx }
              }
              else {
                // Link previous even node to current
                var $prev_node { value = $nodes[$even_tail] }
                var $linked { value = $prev_node|set:"next":$current_idx }
                var $nodes { value = $nodes|set:$even_tail:$linked }
              }
            }
            var $even_tail { value = $current_idx }
          }
        }
        
        // Move to next node
        var $current_idx { value = $next_idx }
        var $position { value = $position + 1 }
      }
    }
    
    // Connect last odd node to even_head, and terminate even list
    conditional {
      if ($even_head != null) {
        // Connect odd tail to even head
        var $last_odd { value = $nodes[$odd_tail] }
        var $connected { value = $last_odd|set:"next":$even_head }
        var $nodes { value = $nodes|set:$odd_tail:$connected }
        
        // Terminate even list
        var $last_even { value = $nodes[$even_tail] }
        var $terminated { value = $last_even|set:"next":null }
        var $nodes { value = $nodes|set:$even_tail:$terminated }
      }
    }
  }

  response = { nodes: $nodes, head_index: $odd_head }
}
