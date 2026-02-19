function "reverse_linked_list" {
  description = "Reverse a singly linked list"
  input {
    json head {
      description = "The head node of the linked list, or null for empty list"
    }
  }
  stack {
    // Handle empty list
    conditional {
      if ($input.head == null) {
        var $result { value = null }
      }
      else {
        // Initialize pointers for reversal
        var $prev { value = null }
        var $current { value = $input.head }
        var $next { value = null }

        // Traverse and reverse links
        while ($current != null) {
          each {
            // Store next node
            var $next { value = $current|get:"next":null }

            // Reverse the link
            var $current {
              value = {
                value: ($current|get:"value":0),
                next: $prev
              }
            }

            // Move pointers forward
            var $prev { value = $current }
            var $current { value = $next }
          }
        }

        // prev is now the new head
        var $result { value = $prev }
      }
    }
  }
  response = $result
}
