// Reorder List - Classic coding interview question
// Reorders a linked list from L0→L1→...→Ln to L0→Ln→L1→Ln-1→L2→Ln-2→...
// Uses the "find middle, reverse second half, merge" approach
function "reorder_list" {
  description = "Reorders a linked list in-place without modifying values"

  input {
    json nodes
    int head_index
  }

  stack {
    // Handle edge cases: empty list or single node
    conditional {
      if (($input.nodes|count) == 0 || ($input.nodes|count) == 1) {
        return { value = { nodes: $input.nodes, head_index: $input.head_index } }
      }
    }

    // Step 1: Find the middle of the list using slow/fast pointers
    var $slow { value = $input.head_index }
    var $fast { value = $input.head_index }

    while ($fast != null) {
      each {
        // Move fast pointer 2 steps
        var $fast_node { value = $input.nodes[$fast] }
        var $fast_next { value = $fast_node|get:"next" }

        conditional {
          if ($fast_next == null) {
            var $fast { value = null }
          }
          else {
            var $fast_next_node { value = $input.nodes[$fast_next] }
            var $fast { value = $fast_next_node|get:"next" }
          }
        }

        // Move slow pointer 1 step (only if fast hasn't reached end)
        conditional {
          if ($fast != null) {
            var $slow_node { value = $input.nodes[$slow] }
            var $slow { value = $slow_node|get:"next" }
          }
        }
      }
    }

    // slow now points to the middle node
    // Step 2: Reverse the second half of the list
    var $second_half_head { value = $slow }
    var $prev { value = null }
    var $current { value = $second_half_head }

    // First, disconnect the first half from the second half
    // Find the node before slow and set its next to null
    var $first_tail { value = $input.head_index }
    var $found_split { value = false }

    while (!$found_split) {
      each {
        var $tail_node { value = $input.nodes[$first_tail] }
        var $tail_next { value = $tail_node|get:"next" }

        conditional {
          if ($tail_next == $slow) {
            // Disconnect here
            var $disconnected_tail { value = $tail_node|set:"next":null }
            var $updated_nodes { value = $input.nodes|set:$first_tail:$disconnected_tail }
            var $found_split { value = true }
          }
          else {
            var $first_tail { value = $tail_next }
          }
        }
      }
    }

    // Now reverse the second half
    var $reversed_nodes { value = $updated_nodes }

    while ($current != null) {
      each {
        var $current_node { value = $reversed_nodes[$current] }
        var $next { value = $current_node|get:"next" }

        // Reverse the link
        var $reversed_node { value = $current_node|set:"next":$prev }
        var $reversed_nodes { value = $reversed_nodes|set:$current:$reversed_node }

        // Move pointers forward
        var $prev { value = $current }
        var $current { value = $next }
      }
    }

    // prev is now the head of the reversed second half
    var $second_head { value = $prev }

    // Step 3: Merge the two halves by alternating nodes
    var $first { value = $input.head_index }
    var $second { value = $second_head }
    var $merged_nodes { value = $reversed_nodes }
    var $new_head { value = $input.head_index }

    while ($second != null) {
      each {
        // Save next pointers
        var $first_node { value = $merged_nodes[$first] }
        var $first_next { value = $first_node|get:"next" }

        var $second_node { value = $merged_nodes[$second] }
        var $second_next { value = $second_node|get:"next" }

        // Link first node to second node
        var $first_linked { value = $first_node|set:"next":$second }
        var $merged_nodes { value = $merged_nodes|set:$first:$first_linked }

        // Link second node to next first node (if exists)
        conditional {
          if ($first_next != null) {
            var $second_linked { value = $second_node|set:"next":$first_next }
            var $merged_nodes { value = $merged_nodes|set:$second:$second_linked }
          }
          else {
            var $second_linked { value = $second_node|set:"next":null }
            var $merged_nodes { value = $merged_nodes|set:$second:$second_linked }
          }
        }

        // Move to next pair
        var $first { value = $first_next }
        var $second { value = $second_next }
      }
    }
  }

  response = { nodes: $merged_nodes, head_index: $new_head }
}
