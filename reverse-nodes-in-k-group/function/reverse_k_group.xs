// Reverse Nodes in k-Group - Classic coding interview question
// Reverses the nodes of a linked list k at a time and returns the modified list
function "reverse_k_group" {
  description = "Reverses nodes of a linked list k at a time"
  
  input {
    json list
    int? head_index?=0
    int k { description = "Number of nodes to reverse at a time" }
  }
  
  stack {
    // Handle edge cases
    conditional {
      if (($input.list|count) == 0 || $input.k <= 1) {
        return { value = { nodes: $input.list, head_index: $input.head_index } }
      }
      elseif ($input.head_index == null) {
        return { value = { nodes: $input.list, head_index: null } }
      }
    }
    
    // Create a copy of the nodes to modify
    var $nodes { value = $input.list }
    var $head { value = $input.head_index }
    var $new_head { value = null }
    var $prev_group_tail { value = null }
    var $current { value = $head }
    
    // Process groups of k nodes
    while ($current != null) {
      each {
        // Check if we have k nodes remaining
        var $count { value = 0 }
        var $check { value = $current }
        
        while ($check != null && $count < $input.k) {
          each {
            var $check { value = $nodes[$check]|get:"next" }
            var $count { value = $count + 1 }
          }
        }
        
        // If fewer than k nodes remain, don't reverse this group
        conditional {
          if ($count < $input.k) {
            // Connect previous group to this remaining group
            conditional {
              if ($prev_group_tail != null) {
                var $nodes {
                  value = $nodes|set:$prev_group_tail:($nodes[$prev_group_tail]|set:"next":$current)
                }
              }
            }
            var $current { value = null }
          }
          else {
            // Reverse k nodes starting from current
            var $group_head { value = $current }
            var $prev { value = null }
            var $i { value = 0 }
            
            while ($i < $input.k) {
              each {
                var $next_node { value = $nodes[$current]|get:"next" }
                var $updated_node {
                  value = $nodes[$current]|set:"next":$prev
                }
                var $nodes {
                  value = $nodes|set:$current:$updated_node
                }
                var $prev { value = $current }
                var $current { value = $next_node }
                var $i { value = $i + 1 }
              }
            }
            
            // Now prev is the new head of reversed group
            // group_head is the new tail
            conditional {
              if ($new_head == null) {
                var $new_head { value = $prev }
              }
            }
            
            // Connect previous group's tail to this group's new head
            conditional {
              if ($prev_group_tail != null) {
                var $nodes {
                  value = $nodes|set:$prev_group_tail:($nodes[$prev_group_tail]|set:"next":$prev)
                }
              }
            }
            
            // Update prev_group_tail to this group's tail (which was group_head)
            var $prev_group_tail { value = $group_head }
          }
        }
      }
    }
    
    // If new_head is still null, no reversal happened
    conditional {
      if ($new_head == null) {
        var $new_head { value = $head }
      }
    }
  }
  
  response = { nodes: $nodes, head_index: $new_head }
}
