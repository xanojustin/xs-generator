function "decimal_to_binary" {
  description = "Converts a decimal (base-10) integer to its binary (base-2) string representation"
  input {
    int number filters=min:0 { description = "Non-negative decimal integer to convert" }
  }
  stack {
    // Handle edge case of 0
    conditional {
      if ($input.number == 0) {
        var $binary_string { value = "0" }
      }
      else {
        // Build binary string by repeatedly dividing by 2 and tracking remainders
        var $binary_string { value = "" }
        var $remaining { value = $input.number }
        
        while ($remaining > 0) {
          each {
            // Get remainder (0 or 1)
            var $remainder { value = $remaining % 2 }
            
            // Prepend remainder to binary string
            text.prepend $binary_string {
              value = $remainder|to_text
            }
            
            // Integer division by 2
            math.div $remaining {
              value = 2
            }
          }
        }
      }
    }
  }
  response = $binary_string
}
