// Count and Say - Classic string sequence problem
// Generates the nth term of the count-and-say sequence
// The sequence starts with "1" and each subsequent term is built by "reading" the previous term
// Example: 1 → "1", 2 → "11" (one 1), 3 → "21" (two 1s), 4 → "1211" (one 2, one 1)
function "count_and_say" {
  description = "Returns the nth term of the count-and-say sequence"

  input {
    int n { description = "The term number to generate (1-indexed)" }
  }

  stack {
    // Handle edge case
    conditional {
      if ($input.n <= 0) {
        var $result { value = "" }
      }
      elseif ($input.n == 1) {
        var $result { value = "1" }
      }
      else {
        // Start with the first term
        var $current { value = "1" }
        var $term { value = 2 }

        // Build each subsequent term up to n
        while ($term <= $input.n) {
          each {
            var $next { value = "" }
            var $i { value = 0 }
            var $len { value = $current|strlen }

            // Process the current term to build the next term
            while ($i < $len) {
              each {
                // Get the current character
                var $char { value = $current|substr:$i:1 }
                var $count { value = 1 }
                var $j { value = $i + 1 }

                // Count consecutive occurrences of the same character
                while ($j < $len) {
                  each {
                    var $next_char { value = $current|substr:$j:1 }
                    conditional {
                      if ($next_char == $char) {
                        var $count { value = $count + 1 }
                        var $j { value = $j + 1 }
                      }
                      else {
                        // Break out of inner while
                        var $j { value = $len }
                      }
                    }
                  }
                }

                // Append count and character to next term
                var $next {
                  value = $next ~ ($count|to_text) ~ $char
                }

                // Move index past the counted characters
                var $i { value = $i + $count }
              }
            }

            // Update current term and increment term counter
            var $current { value = $next }
            var $term { value = $term + 1 }
          }
        }

        var $result { value = $current }
      }
    }
  }

  response = $result
}
