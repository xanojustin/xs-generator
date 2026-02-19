function "string_compression" {
  description = "Compress a string using counts of repeated characters"
  input {
    text input_string filters=trim {
      description = "The string to compress (e.g., 'aabcccccaaa')"
    }
  }
  stack {
    // Convert string to character array for indexed access
    var $chars { value = $input.input_string|split:"" }

    // Handle empty string edge case
    conditional {
      if (($chars|count) == 0) {
        var $compressed { value = "" }
      }
      else {
        // Initialize variables for compression
        var $compressed { value = "" }
        var $current_char { value = $chars|get:0 }
        var $count { value = 1 }
        var $i { value = 1 }

        // Iterate through the string starting from index 1
        while ($i < ($chars|count)) {
          each {
            var $char { value = $chars|get:$i }

            conditional {
              if ($char == $current_char) {
                // Same character, increment count
                var.update $count { value = $count + 1 }
              }
              else {
                // Different character, append current group and reset
                var.update $compressed { value = $compressed ~ $current_char ~ ($count|to_text) }
                var.update $current_char { value = $char }
                var.update $count { value = 1 }
              }
            }

            var.update $i { value = $i + 1 }
          }
        }

        // Append the final character group
        var.update $compressed { value = $compressed ~ $current_char ~ ($count|to_text) }
      }
    }
  }
  response = $compressed
}
