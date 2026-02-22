// Linked List Cycle Detection - Floyd's Tortoise and Hare Algorithm
// Detects if a linked list has a cycle using two pointers moving at different speeds
function "linked_list_cycle" {
  description = "Detects if a linked list contains a cycle using Floyd's algorithm"
  
  input {
    object[] nodes {
      description = "Array of linked list nodes, each with 'value' and 'next' (index of next node, -1 for null)"
    }
  }
  
  stack {
    // Handle empty list or single node (no cycle possible)
    var $has_cycle { value = false }
    var $node_count { value = ($input.nodes|count) }
    
    conditional {
      if (`$node_count <= 1`) {
        var $has_cycle { value = false }
      }
      else {
        // Floyd's Tortoise and Hare algorithm
        // slow moves 1 step at a time, fast moves 2 steps
        // Start both pointers at head (index 0)
        var $slow { value = 0 }
        var $fast { value = 0 }
        var $detected { value = false }
        
        // Continue until fast reaches end or cycle detected
        while (`$detected == false`) {
          each {
            // Move slow pointer 1 step
            var $slow_node { value = $input.nodes|slice:$slow:($slow + 1)|first }
            var $slow_next { value = $slow_node|get:"next" }
            
            // Move fast pointer 2 steps
            var $fast_node { value = $input.nodes|slice:$fast:($fast + 1)|first }
            var $fast_next { value = $fast_node|get:"next" }
            
            // Check if fast can move at all
            conditional {
              if (`$fast_next == -1`) {
                // Fast reached end, no cycle
                var $detected { value = true }
                var $has_cycle { value = false }
              }
              else {
                // Move fast to next node
                var $fast { value = $fast_next }
                var $fast_node2 { value = $input.nodes|slice:$fast:($fast + 1)|first }
                var $fast_next2 { value = $fast_node2|get:"next" }
                
                conditional {
                  if (`$fast_next2 == -1`) {
                    // Fast reached end after 2 steps, no cycle
                    var $detected { value = true }
                    var $has_cycle { value = false }
                  }
                  else {
                    // Move fast second step
                    var $fast { value = $fast_next2 }
                    
                    // Move slow one step
                    var $slow { value = $slow_next }
                    
                    // Check if pointers met (cycle detected)
                    conditional {
                      if (`$slow == $fast`) {
                        var $detected { value = true }
                        var $has_cycle { value = true }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  
  response = $has_cycle
}
