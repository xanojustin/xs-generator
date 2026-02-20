// Caesar Cipher - Classic string encoding exercise
// Shifts each letter in the message by a specified number of positions in the alphabet
// Non-alphabetic characters are preserved unchanged
function "caesar-cipher" {
  description = "Encodes a message using the Caesar cipher technique"
  
  input {
    text message { description = "The message to encode" }
    int shift { description = "Number of positions to shift each letter (positive = right, negative = left)" }
  }
  
  stack {
    var $uppercase { value = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"] }
    var $lowercase { value = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"] }
    var $encoded { value = "" }
    var $i { value = 0 }
    var $msg_len { value = $input.message|strlen }
    
    // Normalize shift to 0-25 range
    var $shift { value = (($input.shift % 26) + 26) % 26 }
    
    while ($i < $msg_len) {
      each {
        var $char { value = $input.message|substr:$i:1 }
        var $found { value = false }
        var $j { value = 0 }
        
        // Check uppercase letters
        while ($j < 26 && !$found) {
          each {
            conditional {
              if (`$char == $uppercase[$j]`) {
                var $new_index { value = ($j + $shift) % 26 }
                var $new_char { value = $uppercase[$new_index] }
                var.update $encoded { value = $encoded ~ $new_char }
                var.update $found { value = true }
              }
            }
            var.update $j { value = $j + 1 }
          }
        }
        
        // Check lowercase letters (only if not found in uppercase)
        conditional {
          if (!$found) {
            var $k { value = 0 }
            while ($k < 26) {
              each {
                conditional {
                  if (`$char == $lowercase[$k]`) {
                    var $new_index { value = ($k + $shift) % 26 }
                    var $new_char { value = $lowercase[$new_index] }
                    var.update $encoded { value = $encoded ~ $new_char }
                    var.update $found { value = true }
                  }
                }
                var.update $k { value = $k + 1 }
              }
            }
          }
        }
        
        // If not a letter, keep the character as-is
        conditional {
          if (!$found) {
            var.update $encoded { value = $encoded ~ $char }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $encoded
}
