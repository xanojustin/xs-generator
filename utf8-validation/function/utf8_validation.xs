// UTF-8 Validation - Check if a byte array represents valid UTF-8 encoding
// UTF-8 encoding rules:
// - 1-byte character: 0xxxxxxx (0-127)
// - 2-byte character: 110xxxxx 10xxxxxx
// - 3-byte character: 1110xxxx 10xxxxxx 10xxxxxx
// - 4-byte character: 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
function "utf8_validation" {
  description = "Validates if a byte array represents valid UTF-8 encoding"
  
  input {
    int[] data { description = "Array of integers representing bytes (0-255)" }
  }
  
  stack {
    var $i { value = 0 }
    var $n { value = $input.data|count }
    var $is_valid { value = true }
    
    while (($i < $n) && $is_valid) {
      each {
        var $byte { value = $input.data[$i] }
        var $remaining_bytes { value = $n - $i - 1 }
        var $bytes_expected { value = 0 }
        
        // Check how many bytes this character should have
        conditional {
          // 1-byte character: 0xxxxxxx (bit 7 is 0, value < 128)
          if ($byte < 128) {
            var.update $bytes_expected { value = 0 }
          }
          // 2-byte character: 110xxxxx (192-223)
          elseif (($byte >= 192) && ($byte <= 223)) {
            var.update $bytes_expected { value = 1 }
          }
          // 3-byte character: 1110xxxx (224-239)
          elseif (($byte >= 224) && ($byte <= 239)) {
            var.update $bytes_expected { value = 2 }
          }
          // 4-byte character: 11110xxx (240-247)
          elseif (($byte >= 240) && ($byte <= 247)) {
            var.update $bytes_expected { value = 3 }
          }
          // Invalid start byte (continuation byte 128-191 or invalid 248-255)
          else {
            var.update $is_valid { value = false }
          }
        }
        
        // Check if we have enough bytes remaining
        conditional {
          if ($is_valid && ($remaining_bytes < $bytes_expected)) {
            var.update $is_valid { value = false }
          }
        }
        
        // Validate continuation bytes (must be 10xxxxxx = 128-191)
        conditional {
          if ($is_valid && ($bytes_expected > 0)) {
            var $j { value = 1 }
            while (($j <= $bytes_expected) && $is_valid) {
              each {
                var $continuation_byte { value = $input.data[$i + $j] }
                // Continuation byte must be between 128 and 191 (10xxxxxx)
                conditional {
                  if (($continuation_byte < 128) || ($continuation_byte > 191)) {
                    var.update $is_valid { value = false }
                  }
                }
                var.update $j { value = $j + 1 }
              }
            }
          }
        }
        
        // Move to next character
        var.update $i { value = $i + 1 + $bytes_expected }
      }
    }
  }
  
  response = $is_valid
}
