// Decode Ways - Dynamic Programming Exercise
// Given a string of digits, count the number of ways to decode it
// where 1-26 maps to A-Z (A=1, B=2, ..., Z=26)
// Uses dynamic programming with O(n) time and O(1) space
function "decode_ways" {
  description = "Count the number of ways to decode a digit string"
  
  input {
    text s { description = "String of digits to decode" }
  }
  
  stack {
    // Get string length
    var $n { value = $input.s|strlen }
    
    // Edge case: empty string
    conditional {
      if (`$n == 0`) {
        return { value = 0 }
      }
    }
    
    // Check if first character is '0' - invalid
    var $first_char { value = $input.s|substr:0:1 }
    conditional {
      if (`$first_char == "0"`) {
        return { value = 0 }
      }
    }
    
    // dp[i] = ways to decode s[0..i-1]
    // We only need two previous values, so use O(1) space
    // prev2 = dp[i-2], prev1 = dp[i-1], current = dp[i]
    var $prev2 { value = 1 }
    var $prev1 { value = 1 }
    var $current { value = 1 }
    
    var $i { value = 2 }
    
    while (`$i <= $n`) {
      each {
        var $current { value = 0 }
        
        // Single digit decode: s[i-1] must not be '0'
        var $single_digit { value = $input.s|substr:($i - 1):1 }
        conditional {
          if (`$single_digit != "0"`) {
            var.update $current { value = $current + $prev1 }
          }
        }
        
        // Two digit decode: s[i-2..i-1] must be 10-26
        var $two_digit_str { value = $input.s|substr:($i - 2):2 }
        var $two_digit { value = $two_digit_str|to_int }
        conditional {
          if (`$two_digit >= 10 && $two_digit <= 26`) {
            var.update $current { value = $current + $prev2 }
          }
        }
        
        // Shift window: prev2 <- prev1, prev1 <- current
        var.update $prev2 { value = $prev1 }
        var.update $prev1 { value = $current }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $prev1
}
