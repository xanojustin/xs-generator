function "merge_k_sorted_lists" {
  description = "Merge k sorted linked lists into one sorted linked list"
  input {
    json lists
  }
  stack {
    // Handle empty input
    conditional {
      if (($input.lists|count) == 0) {
        return { value = [] }
      }
    }

    // Initialize result array
    var $result { value = [] }

    // Flatten all lists into one array
    foreach ($input.lists) {
      each as $list {
        foreach ($list) {
          each as $val {
            var $item { value = { value: $val, processed: false } }
            var.update $result { value = $result|append:$item }
          }
        }
      }
    }

    // Handle case where all lists were empty
    conditional {
      if (($result|count) == 0) {
        return { value = [] }
      }
    }

    // Sort using selection sort (find minimum repeatedly)
    var $sorted { value = [] }

    var $remaining { value = $result|count }

    while ($remaining > 0) {
      each {
        // Find minimum unprocessed value
        var $min_val { value = null }
        var $min_idx { value = -1 }
        var $idx { value = 0 }

        foreach ($result) {
          each as $item {
            conditional {
              if ($item.processed == false) {
                conditional {
                  if ($min_val == null || $item.value < $min_val) {
                    var.update $min_val { value = $item.value }
                    var.update $min_idx { value = $idx }
                  }
                }
              }
            }
            var.update $idx { value = $idx + 1 }
          }
        }

        // Mark as processed and add to sorted
        conditional {
          if ($min_idx >= 0) {
            // Update the item to mark as processed
            var $updated_item { value = $result|get:$min_idx }
            var $new_item { value = { value: $updated_item.value, processed: true } }
            var.update $result { value = $result|set:$min_idx:$new_item }

            // Add value to sorted array
            var.update $sorted { value = $sorted|append:$min_val }
            var.update $remaining { value = $remaining - 1 }
          }
        }
      }
    }
  }
  response = $sorted
}
