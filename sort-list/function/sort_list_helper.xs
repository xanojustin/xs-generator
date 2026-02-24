// Helper function for recursive merge sort on linked list
// Splits the list into two halves, recursively sorts each half, then merges them
function "sort_list_helper" {
  description = "Recursively splits and sorts a linked list using merge sort"
  
  input {
    json nodes { description = "Array of node objects" }
    int head { description = "Index of the head node" }
  }
  
  stack {
    // Check if list has 0 or 1 nodes (base case)
    var $head_node { value = $input.nodes[$input.head] }
    var $next_idx { value = $head_node|get:"next" }
    
    conditional {
      if ($next_idx == null) {
        // Single node - already sorted
        var $result { 
          value = { nodes: $input.nodes, head_index: $input.head } 
        }
      }
      else {
        // Find the middle of the list using slow/fast pointer technique
        var $slow { value = $input.head }
        var $fast { value = $input.head }
        var $slow_prev { value = null }
        
        while ($fast != null) {
          each {
            // Move fast pointer 2 steps
            var $fast_node { value = $input.nodes[$fast] }
            var $fast_next { value = $fast_node|get:"next" }
            
            conditional {
              if ($fast_next != null) {
                var $fast_next_node { value = $input.nodes[$fast_next] }
                var $fast { value = $fast_next_node|get:"next" }
              }
              else {
                var $fast { value = null }
              }
            }
            
            // Move slow pointer 1 step
            conditional {
              if ($fast != null) {
                var $slow_prev { value = $slow }
                var $slow_node { value = $input.nodes[$slow] }
                var $slow { value = $slow_node|get:"next" }
              }
            }
          }
        }
        
        // Split the list at the middle
        // slow now points to the start of the second half
        var $second_half_head { value = $slow }
        
        // Update the first half to end at slow_prev
        conditional {
          if ($slow_prev != null) {
            var $first_half_tail { value = $input.nodes[$slow_prev] }
            var $first_half_tail { 
              value = $first_half_tail|set:"next":null 
            }
            var $updated_nodes { 
              value = $input.nodes|set:$slow_prev:$first_half_tail 
            }
          }
          else {
            var $updated_nodes { value = $input.nodes }
          }
        }
        
        // Recursively sort both halves
        function.run "sort_list_helper" {
          input = { 
            nodes: $updated_nodes,
            head: $input.head 
          }
        } as $first_sorted
        
        function.run "sort_list_helper" {
          input = { 
            nodes: $updated_nodes,
            head: $second_half_head 
          }
        } as $second_sorted
        
        // Merge the two sorted halves
        function.run "merge_sorted_linked_lists" {
          input = {
            nodes: $first_sorted.nodes,
            head1: $first_sorted.head_index,
            head2: $second_sorted.head_index
          }
        } as $merged
        
        var $result { value = $merged }
      }
    }
  }
  
  response = $result
}
