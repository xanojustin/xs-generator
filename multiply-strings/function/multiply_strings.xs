function "multiply_strings" {
  description = "Multiply two numbers represented as strings"
  input {
    text num1 filters=trim
    text num2 filters=trim
  }
  stack {
    // Handle edge case: if either number is "0", return "0"
    conditional {
      if ($input.num1 == "0" || $input.num2 == "0") {
        return { value = "0" }
      }
    }

    // Get lengths of both numbers
    var $len1 { value = $input.num1|strlen }
    var $len2 { value = $input.num2|strlen }

    // Result array to store digits (max length is len1 + len2)
    var $result_digits { value = [] }

    // Initialize result array with zeros
    var $total_len { value = $len1 + $len2 }
    var $i { value = 0 }
    while ($i < $total_len) {
      each {
        var $result_digits { value = $result_digits|push:0 }
        var.update $i { value = $i + 1 }
      }
    }

    // Multiply each digit
    var $i { value = $len1 - 1 }
    while ($i >= 0) {
      each {
        var $digit1 { value = ($input.num1|substr:$i:1)|to_int }
        var $carry { value = 0 }
        var $j { value = $len2 - 1 }

        while ($j >= 0) {
          each {
            var $digit2 { value = ($input.num2|substr:$j:1)|to_int }
            var $pos { value = $i + $j + 1 }
            var $current { value = ($result_digits|get:$pos:0) + ($digit1 * $digit2) + $carry }
            
            var.update $result_digits {
              value = $result_digits|set:$pos:($current % 10)
            }
            var $carry { value = ($current / 10)|floor }
            var.update $j { value = $j - 1 }
          }
        }

        // Add remaining carry to the leftmost position
        conditional {
          if ($carry > 0) {
            var $pos { value = $i }
            var $current { value = ($result_digits|get:$pos:0) + $carry }
            var.update $result_digits {
              value = $result_digits|set:$pos:$current
            }
          }
        }

        var.update $i { value = $i - 1 }
      }
    }

    // Convert result array to string, skipping leading zeros
    var $result_str { value = "" }
    var $leading_zero { value = true }
    var $k { value = 0 }

    while ($k < $total_len) {
      each {
        var $digit { value = $result_digits|get:$k:0 }
        
        conditional {
          if ($leading_zero && $digit == 0) {
            // Skip leading zeros
          }
          else {
            var.update $result_str {
              value = $result_str ~ ($digit|to_text)
            }
            var $leading_zero { value = false }
          }
        }
        
        var.update $k { value = $k + 1 }
      }
    }

    // Handle case where result is empty (shouldn't happen with our edge case check)
    conditional {
      if ($result_str == "") {
        var $result_str { value = "0" }
      }
    }
  }
  response = $result_str
}
