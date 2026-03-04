// Sequential Digits - Generate all sequential digit numbers in a range
// An integer has sequential digits if each digit is exactly one more than the previous digit
// Example: 123, 4567, 2345 are sequential; 124, 321, 135 are not
function "sequential_digits" {
  description = "Finds all sequential digit numbers in the range [low, high]"

  input {
    int low { description = "Lower bound of the range (inclusive)" }
    int high { description = "Upper bound of the range (inclusive)" }
  }

  stack {
    var $result { value = [] }

    // Generate all possible sequential digit numbers
    // Start with each digit 1-9 and build up sequentially
    var $start_digit { value = 1 }

    while ($start_digit <= 9) {
      each {
        var $current { value = $start_digit }
        var $next_digit { value = $start_digit + 1 }

        // Keep appending next digit while we haven't exceeded high
        while ($current <= $input.high && $next_digit <= 9) {
          each {
            // Check if current number is in range
            conditional {
              if ($current >= $input.low && $current <= $input.high) {
                var $result {
                  value = $result|merge:[$current]
                }
              }
            }

            // Build next sequential number by appending next_digit
            // current = current * 10 + next_digit
            var $current {
              value = ($current * 10) + $next_digit
            }
            var $next_digit { value = $next_digit + 1 }
          }
        }

        // Check the final number after the loop (might be valid)
        conditional {
          if ($current >= $input.low && $current <= $input.high) {
            var $result {
              value = $result|merge:[$current]
            }
          }
        }

        var.update $start_digit { value = $start_digit + 1 }
      }
    }

    // Sort the result before returning
    var $sorted_result { value = $result|sort }
  }

  response = $sorted_result
}
