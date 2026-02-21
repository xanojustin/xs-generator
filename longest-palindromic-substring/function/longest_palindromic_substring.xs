// Longest Palindromic Substring - Classic coding exercise
// Given a string, find the longest substring that is a palindrome
// Uses the "expand around center" approach for O(n²) time complexity
function "longest_palindromic_substring" {
  description = "Finds the longest palindromic substring in a given string"

  input {
    text s { description = "The input string to search" }
  }

  stack {
    var $str_len { value = $input.s|strlen }

    // Handle empty or single character string
    conditional {
      if (($str_len <= 1)) {
        var $result { value = $input.s }
      }
      else {
        // Variables to track the longest palindrome found
        var $start { value = 0 }
        var $max_length { value = 1 }

        var $i { value = 0 }

        while ($i < $str_len) {
          each {
            // Check for odd-length palindromes (single character center)
            var $left { value = $i }
            var $right { value = $i }

            // Expand while characters match and within bounds
            while (($left >= 0) && ($right < $str_len)) {
              each {
                var $left_char { value = $input.s|substr:$left:1 }
                var $right_char { value = $input.s|substr:$right:1 }

                conditional {
                  if ($left_char == $right_char) {
                    // Calculate current palindrome length
                    var $current_len { value = $right - $left + 1 }

                    conditional {
                      if ($current_len > $max_length) {
                        var $start { value = $left }
                        var $max_length { value = $current_len }
                      }
                    }

                    // Move outward
                    var.update $left { value = $left - 1 }
                    var.update $right { value = $right + 1 }
                  }
                  else {
                    // Break the inner while loop by setting condition to false
                    var $left { value = -1 }
                  }
                }
              }
            }

            // Check for even-length palindromes (between two characters)
            var $left2 { value = $i }
            var $right2 { value = $i + 1 }

            while (($left2 >= 0) && ($right2 < $str_len)) {
              each {
                var $left2_char { value = $input.s|substr:$left2:1 }
                var $right2_char { value = $input.s|substr:$right2:1 }

                conditional {
                  if ($left2_char == $right2_char) {
                    // Calculate current palindrome length
                    var $current_len2 { value = $right2 - $left2 + 1 }

                    conditional {
                      if ($current_len2 > $max_length) {
                        var $start { value = $left2 }
                        var $max_length { value = $current_len2 }
                      }
                    }

                    // Move outward
                    var.update $left2 { value = $left2 - 1 }
                    var.update $right2 { value = $right2 + 1 }
                  }
                  else {
                    // Break the inner while loop
                    var $left2 { value = -1 }
                  }
                }
              }
            }

            var.update $i { value = $i + 1 }
          }
        }

        // Extract the longest palindrome substring
        var $result {
          value = $input.s|substr:$start:$max_length
        }
      }
    }
  }

  response = $result
}
