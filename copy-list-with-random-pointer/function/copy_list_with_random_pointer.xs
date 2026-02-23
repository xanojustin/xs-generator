// Copy List with Random Pointer - Deep copy a linked list with random pointers
// Each node has: value, next (index), and random (index to any node or null)
function "copy_list_with_random_pointer" {
  description = "Creates a deep copy of a linked list where each node has next and random pointers"

  input {
    json nodes
    int? head_index?=0
  }

  stack {
    // Handle edge cases
    conditional {
      if (($input.nodes|count) == 0) {
        return { value = { nodes: [], head_index: null } }
      }
      elseif ($input.head_index == null) {
        return { value = { nodes: [], head_index: null } }
      }
    }

    // Step 1: Create a mapping from original index to new index
    // and build the new nodes array with values
    var $old_to_new { value = {} }
    var $new_nodes { value = [] }
    var $i { value = 0 }

    while ($i < ($input.nodes|count)) {
      each {
        // Map old index to new index
        var $old_to_new {
          value = $old_to_new|set:$i:(($new_nodes|count))
        }

        // Create new node with same value, null pointers for now
        var $original_node { value = $input.nodes[$i] }
        var $new_node {
          value = {
            value: ($original_node|get:"value"),
            next: null,
            random: null
          }
        }
        var $new_nodes {
          value = $new_nodes|merge:[$new_node]
        }

        var $i { value = $i + 1 }
      }
    }

    // Step 2: Set the next and random pointers using the mapping
    var $j { value = 0 }

    while ($j < ($input.nodes|count)) {
      each {
        var $original_node { value = $input.nodes[$j] }
        var $new_node { value = $new_nodes[$j] }

        // Map next pointer
        var $original_next { value = $original_node|get:"next" }
        conditional {
          if ($original_next != null) {
            var $new_next { value = $old_to_new|get:($original_next|to_text) }
            var $new_node {
              value = $new_node|set:"next":$new_next
            }
          }
        }

        // Map random pointer
        var $original_random { value = $original_node|get:"random" }
        conditional {
          if ($original_random != null) {
            var $new_random { value = $old_to_new|get:($original_random|to_text) }
            var $new_node {
              value = $new_node|set:"random":$new_random
            }
          }
        }

        // Update the node in the array
        var $new_nodes {
          value = $new_nodes|set:$j:$new_node
        }

        var $j { value = $j + 1 }
      }
    }

    // Get the new head index
    var $new_head { value = $old_to_new|get:($input.head_index|to_text) }
  }

  response = { nodes: $new_nodes, head_index: $new_head }
}
