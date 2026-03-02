// Middle of the Linked List - Classic coding interview question
// Finds the middle node of a singly linked list using the slow/fast pointer technique
// If there are two middle nodes, returns the second one
function "middle_of_linked_list" {
  description = "Returns the middle node of a linked list"

  input {
    json list
    int? head_index?=0
  }

  stack {
    // Handle edge cases
    conditional {
      if (($input.list|count) == 0) {
        return { value = { nodes: [], middle_index: null, middle_value: null } }
      }
      elseif ($input.head_index == null) {
        return { value = { nodes: $input.list, middle_index: null, middle_value: null } }
      }
    }

    // Initialize slow and fast pointers
    var $slow { value = $input.head_index }
    var $fast { value = $input.head_index }

    // Traverse: slow moves 1 step, fast moves 2 steps
    // When fast reaches the end, slow is at the middle
    while ($fast != null) {
      each {
        // Get fast's next node
        var $fast_next { value = $input.list[$fast]|get:"next" }

        // If fast can move 2 steps, advance slow by 1
        conditional {
          if ($fast_next != null) {
            // Move slow 1 step
            var $slow_next { value = $input.list[$slow]|get:"next" }
            var $slow { value = $slow_next }

            // Move fast 2 steps (fast_next is already 1 step)
            var $fast_next_next { value = $input.list[$fast_next]|get:"next" }
            var $fast { value = $fast_next_next }
          }
          else {
            // Fast can only move 1 more step, we're done
            // This handles odd-length lists where fast ends at last node
            var $fast { value = null }
          }
        }
      }
    }

    // Get the middle node's value
    var $middle_value { value = $input.list[$slow]|get:"value" }
  }

  response = { nodes: $input.list, middle_index: $slow, middle_value: $middle_value }
}
