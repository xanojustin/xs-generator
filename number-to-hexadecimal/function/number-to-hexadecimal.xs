// Convert a Number to Hexadecimal
// Given an integer, return its hexadecimal representation as a lowercase string.
// For negative integers, two's complement method is used (32-bit).
function "number-to-hexadecimal" {
  description = "Converts an integer to its hexadecimal representation"
  
  input {
    int num { description = "The integer to convert to hexadecimal" }
  }
  
  stack {
    var $hex_chars { value = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"] }
    var $result { value = "" }
    var $n { value = $input.num }
    
    // Handle zero case
    conditional {
      if ($n == 0) {
        var $result { value = "0" }
      }
      else {
        // Handle negative numbers using two's complement (32-bit)
        conditional {
          if ($n < 0) {
            var $n { value = $n + 4294967296 }
          }
        }
        
        // Convert to hexadecimal
        while ($n > 0) {
          each {
            var $remainder { value = $n % 16 }
            var $hex_digit { value = $hex_chars[$remainder] }
            var $result { value = $hex_digit ~ $result }
            var $n { value = ($n / 16)|to_int }
          }
        }
      }
    }
  }
  
  response = $result
}
