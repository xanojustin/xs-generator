// Add Binary - Classic coding exercise
// Given two binary strings, return their sum (also a binary string)
// Simulates binary addition with carry handling
function "add_binary" {
  description = "Adds two binary strings and returns the sum as a binary string"

  input {
    text a { description = "First binary string (contains only 0s and 1s)" }
    text b { description = "Second binary string (contains only 0s and 1s)" }
  }

  stack {
    // Get lengths of both strings
    var $len_a { value = $input.a|strlen }
    var $len_b { value = $input.b|strlen }

    // Initialize pointers at the end of each string
    var $i { value = $len_a - 1 }
    var $j { value = $len_b - 1 }

    // Result and carry
    var $result { value = "" }
    var $carry { value = 0 }

    // Process digits from right to left
    while (`$i >= 0 || $j >= 0 || $carry > 0`) {
      each {
        // Get current digit from a (or 0 if exhausted)
        var $digit_a { value = 0 }
        conditional {
          if (`$i >= 0`) {
            var $char_a { value = $input.a|substr:$i:1 }
            var $digit_a { value = $char_a|to_int }
          }
        }

        // Get current digit from b (or 0 if exhausted)
        var $digit_b { value = 0 }
        conditional {
          if (`$j >= 0`) {
            var $char_b { value = $input.b|substr:$j:1 }
            var $digit_b { value = $char_b|to_int }
          }
        }

        // Calculate sum and new carry
        var $sum { value = $digit_a + $digit_b + $carry }
        var $current_digit { value = $sum % 2 }
        var $carry { value = $sum / 2 }

        // Prepend current digit to result
        var $result {
          value = ($current_digit|to_text) ~ $result
        }

        // Move pointers left
        var.update $i { value = $i - 1 }
        var.update $j { value = $j - 1 }
      }
    }

    // Handle empty result case (both inputs were empty)
    conditional {
      if (`($result|strlen) == 0`) {
        var $result { value = "0" }
      }
    }
  }

  response = $result
}
