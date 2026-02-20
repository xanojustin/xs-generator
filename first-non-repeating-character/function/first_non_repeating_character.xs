// First Non-Repeating Character
// Finds the first character in a string that appears only once
// Returns the index of that character, or -1 if no unique character exists
function "first_non_repeating_character" {
  description = "Finds the index of the first non-repeating character in a string"

  input {
    text s { description = "The input string to search" }
  }

  stack {
    // Get the length of the input string
    var $length { value = $input.s|strlen }

    // Edge case: empty string
    conditional {
      if ($length == 0) {
        var $result { value = -1 }
      }
    }

    // Only proceed if string is not empty
    conditional {
      if ($length > 0) {
        // Build frequency map using parallel arrays (char and count)
        // Since XanoScript doesn't have a native map/dict for mutation,
        // we'll check each character against all others

        var $result { value = -1 }
        var $i { value = 0 }

        // Outer loop: check each character
        while (($i < $length) && ($result == -1)) {
          each {
            var $char { value = $input.s|substr:$i:1 }
            var $count { value = 0 }
            var $j { value = 0 }

            // Inner loop: count occurrences of this character
            while ($j < $length) {
              each {
                var $compare_char { value = $input.s|substr:$j:1 }

                conditional {
                  if ($char == $compare_char) {
                    var.update $count { value = $count + 1 }
                  }
                }

                var.update $j { value = $j + 1 }
              }
            }

            // If this character appears only once, we found our answer
            conditional {
              if ($count == 1) {
                var $result { value = $i }
              }
            }

            var.update $i { value = $i + 1 }
          }
        }
      }
    }
  }

  response = $result
}
