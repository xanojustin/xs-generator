function "longest_repeating_character_replacement" {
  description = "Find the length of the longest substring containing the same letter after performing at most k character replacements"
  input {
    text s filters=trim
    int k filters=min:0
  }
  stack {
    // Handle edge cases
    conditional {
      if (($input.s|strlen) == 0) {
        return { value = 0 }
      }
    }

    // Initialize variables for sliding window
    var $left { value = 0 }
    var $max_len { value = 0 }
    var $max_freq { value = 0 }
    var $char_count { value = {} }

    // Iterate through string with right pointer
    for (($input.s|strlen)) {
      each as $right {
        // Get current character
        var $char { value = $input.s|substr:$right:1 }

        // Update character count
        var $current_count {
          value = ($char_count|get:$char:0) + 1
        }
        var.update $char_count {
          value = $char_count|set:$char:$current_count
        }

        // Update max frequency
        conditional {
          if ($current_count > $max_freq) {
            var.update $max_freq { value = $current_count }
          }
        }

        // Window size - max frequency > k means we need to shrink
        var $window_size { value = $right - $left + 1 }

        // While window is invalid (too many replacements needed), shrink from left
        while (($window_size - $max_freq) > $input.k) {
          each {
            // Get leftmost character
            var $left_char { value = $input.s|substr:$left:1 }

            // Decrement count for left character
            var $left_count {
              value = ($char_count|get:$left_char:0) - 1
            }
            var.update $char_count {
              value = $char_count|set:$left_char:$left_count
            }

            // Move left pointer
            var.update $left { value = $left + 1 }

            // Recalculate window size
            var.update $window_size { value = $right - $left + 1 }
          }
        }

        // Update max length if current window is larger
        conditional {
          if ($window_size > $max_len) {
            var.update $max_len { value = $window_size }
          }
        }
      }
    }
  }
  response = $max_len
}
