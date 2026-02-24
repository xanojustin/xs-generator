function "first_unique_char" {
  description = "Find the index of the first non-repeating character in a string"
  input {
    text s { description = "Input string to search" }
  }
  stack {
    // Handle empty string edge case
    precondition (($input.s|strlen) > 0) {
      error_type = "inputerror"
      error = "Input string cannot be empty"
    }

    // Build character frequency map
    var $char_counts { value = {} }
    var $first_indices { value = {} }
    var $index { value = 0 }

    // Iterate through string to build frequency map
    foreach ($input.s|split:"") {
      each as $char {
        conditional {
          if ($char_counts|has:$char) {
            // Increment count for existing character
            var $current_count { value = $char_counts|get:$char }
            var.update $char_counts { 
              value = $char_counts|set:$char:($current_count + 1)
            }
          }
          else {
            // New character - set count to 1 and record first index
            var.update $char_counts { 
              value = $char_counts|set:$char:1
            }
            var.update $first_indices {
              value = $first_indices|set:$char:$index
            }
          }
        }
        var.update $index { value = $index + 1 }
      }
    }

    // Find first character with count == 1
    var $result { value = -1 }
    var $min_index { value = -1 }

    foreach ($char_counts|split:""|filter:`$$ != ":"`) {
      each as $key_value {
        // Parse key:value pair (format from object split)
        var $parts { value = $key_value|split:":" }
        var $char { value = $parts|first }
        var $count_str { value = $parts|last }
        var $count { value = $count_str|to_int }

        conditional {
          if ($count == 1) {
            var $char_index { value = $first_indices|get:$char|to_int }
            conditional {
              if ($min_index == -1 || $char_index < $min_index) {
                var.update $min_index { value = $char_index }
              }
            }
          }
        }
      }
    }

    var.update $result { value = $min_index }
  }
  response = $result
}
