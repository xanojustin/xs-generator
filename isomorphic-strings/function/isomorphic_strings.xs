// Isomorphic Strings - String mapping exercise
// Two strings are isomorphic if characters in s can be replaced to get t.
// All occurrences of a character must be replaced, and no two characters may map to the same character.
function "isomorphic_strings" {
  description = "Determines if two strings are isomorphic"

  input {
    text s { description = "First string" }
    text t { description = "Second string" }
  }

  stack {
    // First check: strings must be same length
    conditional {
      if (($input.s|strlen) != ($input.t|strlen)) {
        var $is_isomorphic { value = false }
      }
      else {
        // Build character mapping from s to t
        var $s_to_t { value = {} }
        var $t_to_s { value = {} }
        var $is_isomorphic { value = true }
        var $index { value = 0 }

        // Convert strings to character arrays
        var $s_chars { value = $input.s|split:"" }
        var $t_chars { value = $input.t|split:"" }

        // Iterate through characters
        while ($index < ($input.s|strlen) && $is_isomorphic) {
          each {
            // Get current characters from both strings
            var $s_char_array {
              value = $s_chars|slice:$index:($index + 1)
            }
            var $t_char_array {
              value = $t_chars|slice:$index:($index + 1)
            }
            var $s_char { value = $s_char_array|first }
            var $t_char { value = $t_char_array|first }

            // Check if s_char already has a mapping
            conditional {
              if ($s_to_t|has:$s_char) {
                // Existing mapping must match current t_char
                var $existing_mapping {
                  value = $s_to_t|get:$s_char
                }
                conditional {
                  if ($existing_mapping != $t_char) {
                    var $is_isomorphic { value = false }
                  }
                }
              }
              else {
                // No mapping exists - create one
                var $s_to_t {
                  value = $s_to_t|set:$s_char:$t_char
                }
              }
            }

            // Check reverse mapping (t to s) to ensure no two chars map to same char
            conditional {
              if ($is_isomorphic) {
                conditional {
                  if ($t_to_s|has:$t_char) {
                    var $reverse_mapping {
                      value = $t_to_s|get:$t_char
                    }
                    conditional {
                      if ($reverse_mapping != $s_char) {
                        var $is_isomorphic { value = false }
                      }
                    }
                  }
                  else {
                    var $t_to_s {
                      value = $t_to_s|set:$t_char:$s_char
                    }
                  }
                }
              }
            }

            var.update $index { value = $index + 1 }
          }
        }
      }
    }
  }

  response = $is_isomorphic
}
