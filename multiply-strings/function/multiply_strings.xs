// Multiply Strings - Multiply two non-negative integers represented as strings
// Uses elementary school multiplication algorithm (digit by digit)
// Handles arbitrarily large numbers that exceed standard integer limits
function "multiply_strings" {
  description = "Multiplies two non-negative integers represented as strings"
  
  input {
    text num1 { description = "First number as a string" }
    text num2 { description = "Second number as a string" }
  }
  
  stack {
    // Handle edge case where either number is zero
    conditional {
      if ($input.num1 == "0" || $input.num2 == "0") {
        var $final_result { value = "0" }
      }
      else {
        // Get lengths of both numbers
        var $len1 { value = $input.num1|strlen }
        var $len2 { value = $input.num2|strlen }
        
        // Result array to store intermediate sums (max length is len1 + len2)
        var $total_len { value = $len1 + $len2 }
        var $result_digits { value = [] }
        
        // Initialize result array with zeros
        var $k { value = 0 }
        while ($k < $total_len) {
          each {
            array.push $result_digits {
              value = 0
            }
            math.add $k { value = 1 }
          }
        }
        
        // Multiply each digit of num1 with each digit of num2
        var $i { value = $len1 - 1 }
        while ($i >= 0) {
          each {
            // Get digit from num1
            var $char1 { value = $input.num1|substr:$i:1 }
            var $digit1 { value = $char1|to_int }
            
            var $j { value = $len2 - 1 }
            while ($j >= 0) {
              each {
                // Get digit from num2
                var $char2 { value = $input.num2|substr:$j:1 }
                var $digit2 { value = $char2|to_int }
                
                // Position in result array
                var $pos1 { value = $i + $j }
                var $pos2 { value = $pos1 + 1 }
                
                // Get current values at positions
                var $val1 { value = $result_digits[$pos1] }
                var $val2 { value = $result_digits[$pos2] }
                
                // Multiply and add to position
                var $product { value = $digit1 * $digit2 }
                var $sum { value = $product + $val2 }
                
                // Calculate new digit and carry
                var $new_digit { value = $sum % 10 }
                var $carry { value = ($sum / 10)|floor }
                
                // Update result array - rebuild with new values
                // Since we can't edit array elements directly, we use a workaround
                // Store values in temporary variables and rebuild
                var $temp_digits { value = [] }
                var $idx { value = 0 }
                while ($idx < $total_len) {
                  each {
                    conditional {
                      if ($idx == $pos2) {
                        array.push $temp_digits {
                          value = $new_digit
                        }
                      }
                      else {
                        conditional {
                          if ($idx == $pos1) {
                            array.push $temp_digits {
                              value = $val1 + $carry
                            }
                          }
                          else {
                            array.push $temp_digits {
                              value = $result_digits[$idx]
                            }
                          }
                        }
                      }
                    }
                    math.add $idx { value = 1 }
                  }
                }
                var $result_digits { value = $temp_digits }
                
                math.add $j { value = -1 }
              }
            }
            
            math.add $i { value = -1 }
          }
        }
        
        // Convert result array to string
        var $result_str { value = "" }
        var $leading_zero { value = true }
        var $idx2 { value = 0 }
        while ($idx2 < $total_len) {
          each {
            var $digit { value = $result_digits[$idx2] }
            
            conditional {
              if ($leading_zero && $digit == 0) {
                // Skip leading zeros - do nothing
                var $dummy { value = 0 }
              }
              else {
                var $leading_zero { value = false }
                var $result_str { value = $result_str ~ ($digit|to_text) }
              }
            }
            
            math.add $idx2 { value = 1 }
          }
        }
        
        // If result is still empty, it was all zeros
        conditional {
          if ($result_str == "") {
            var $final_result { value = "0" }
          }
          else {
            var $final_result { value = $result_str }
          }
        }
      }
    }
  }
  
  response = $final_result
}
