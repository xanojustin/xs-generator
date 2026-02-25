// Backspace String Compare - Stack-based string manipulation
// Given two strings s and t, return true if they are equal when both are typed
// into empty text editors. '#' means a backspace character.
function "backspace_compare" {
  description = "Compare two strings after processing backspace characters"

  input {
    text s { description = "First string with backspace characters (#)" }
    text t { description = "Second string with backspace characters (#)" }
  }

  stack {
    // Process string s - build result after applying backspaces
    var $result_s { value = [] }
    var $chars_s { value = $input.s|split:"" }
    var $i { value = 0 }

    while ($i < ($chars_s|count)) {
      each {
        var $char { value = $chars_s[$i] }

        conditional {
          // If backspace, remove last character from result (if not empty)
          if ($char == "#") {
            conditional {
              if (($result_s|count) > 0) {
                // Pop from stack by creating new array without last element
                var $new_s { value = [] }
                var $j { value = 0 }
                while ($j < (($result_s|count) - 1)) {
                  each {
                    var $new_s { value = $new_s|merge:[$result_s[$j]] }
                    var.update $j { value = $j + 1 }
                  }
                }
                var $result_s { value = $new_s }
              }
            }
          }
          // Otherwise, push character to stack
          else {
            var $result_s { value = $result_s|merge:[$char] }
          }
        }

        var.update $i { value = $i + 1 }
      }
    }

    // Process string t - build result after applying backspaces
    var $result_t { value = [] }
    var $chars_t { value = $input.t|split:"" }
    var $k { value = 0 }

    while ($k < ($chars_t|count)) {
      each {
        var $char { value = $chars_t[$k] }

        conditional {
          // If backspace, remove last character from result (if not empty)
          if ($char == "#") {
            conditional {
              if (($result_t|count) > 0) {
                // Pop from stack by creating new array without last element
                var $new_t { value = [] }
                var $m { value = 0 }
                while ($m < (($result_t|count) - 1)) {
                  each {
                    var $new_t { value = $new_t|merge:[$result_t[$m]] }
                    var.update $m { value = $m + 1 }
                  }
                }
                var $result_t { value = $new_t }
              }
            }
          }
          // Otherwise, push character to stack
          else {
            var $result_t { value = $result_t|merge:[$char] }
          }
        }

        var.update $k { value = $k + 1 }
      }
    }

    // Compare the two processed results
    var $are_equal { value = true }

    conditional {
      // Different lengths means not equal
      if (($result_s|count) != ($result_t|count)) {
        var $are_equal { value = false }
      }
      else {
        // Compare character by character
        var $n { value = 0 }
        while ($n < ($result_s|count)) {
          each {
            conditional {
              if ($result_s[$n] != $result_t[$n]) {
                var $are_equal { value = false }
              }
            }
            var.update $n { value = $n + 1 }
          }
        }
      }
    }
  }

  response = $are_equal
}
