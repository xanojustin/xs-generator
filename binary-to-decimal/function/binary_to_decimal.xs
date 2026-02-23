// Binary to Decimal Converter
// Converts a binary string (e.g., "1010") to its decimal (base-10) integer equivalent
function "binary_to_decimal" {
  description = "Converts a binary string representation to its decimal integer equivalent"
  
  input {
    text binary_string { description = "Binary string containing only '0's and '1's" }
  }
  
  stack {
    // Initialize result to 0
    var $decimal { value = 0 }
    
    // Get length of binary string
    var $length { value = $input.binary_string|strlen }
    
    // Handle empty string edge case
    conditional {
      if ($length == 0) {
        var $decimal { value = 0 }
      }
      else {
        // Iterate through each character in the binary string
        var $i { value = 0 }
        
        while ($i < $length) {
          each {
            // Get the current bit character
            var $bit_char { value = $input.binary_string|slice:$i:1 }
            
            // Convert bit character to integer (0 or 1)
            conditional {
              if ($bit_char == "1") {
                var $bit { value = 1 }
              }
              else {
                var $bit { value = 0 }
              }
            }
            
            // Calculate position power: 2^(length - i - 1)
            // Leftmost digit has highest power
            var $position { value = $length - $i - 1 }
            var $power { value = 1 }
            
            // Calculate 2^position
            var $p { value = 0 }
            while ($p < $position) {
              each {
                var $power { value = $power * 2 }
                var.update $p { value = $p + 1 }
              }
            }
            
            // Add bit * power to decimal result
            var $decimal { value = $decimal + ($bit * $power) }
            
            // Move to next bit
            var.update $i { value = $i + 1 }
          }
        }
      }
    }
  }
  
  response = $decimal
}
