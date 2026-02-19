function "caesar_cipher" {
  description = "Encrypt text using the Caesar cipher algorithm"
  input {
    text text filters=trim {
      description = "The text to encrypt"
    }
    int shift {
      description = "The shift amount (positive for encryption, negative for decryption)"
    }
  }
  stack {
    // Define alphabet arrays for character lookup
    var $uppercase { value = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"] }
    var $lowercase { value = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"] }
    
    // Handle empty string case
    conditional {
      if (($input.text|strlen) == 0) {
        var $result { value = "" }
      }
      else {
        // Split text into characters
        var $chars { value = $input.text|split:"" }
        var $encrypted_chars { value = [] }
        var $i { value = 0 }
        
        // Normalize shift to 0-25 range
        var $normalized_shift { value = (($input.shift % 26) + 26) % 26 }
        
        while ($i < ($chars|count)) {
          each {
            var $char { value = $chars|get:$i }
            var $encrypted_char { value = $char }
            var $found_index { value = -1 }
            var $j { value = 0 }
            
            // Check if uppercase letter
            while ($j < 26) {
              each {
                conditional {
                  if ($char == ($uppercase|get:$j)) {
                    var.update $found_index { value = $j }
                  }
                }
                var.update $j { value = $j + 1 }
              }
            }
            
            // If found in uppercase, apply shift
            conditional {
              if ($found_index >= 0) {
                var $new_index { value = ($found_index + $normalized_shift) % 26 }
                var.update $encrypted_char { value = $uppercase|get:$new_index }
              }
            }
            
            // If not found in uppercase, check lowercase
            conditional {
              if ($found_index < 0) {
                var.update $j { value = 0 }
                while ($j < 26) {
                  each {
                    conditional {
                      if ($char == ($lowercase|get:$j)) {
                        var.update $found_index { value = $j }
                      }
                    }
                    var.update $j { value = $j + 1 }
                  }
                }
                
                // If found in lowercase, apply shift
                conditional {
                  if ($found_index >= 0) {
                    var $new_index { value = ($found_index + $normalized_shift) % 26 }
                    var.update $encrypted_char { value = $lowercase|get:$new_index }
                  }
                }
              }
            }
            
            // Add encrypted character to result array
            var.update $encrypted_chars { value = $encrypted_chars|push:$encrypted_char }
            var.update $i { value = $i + 1 }
          }
        }
        
        // Join encrypted characters back into a string
        var $result { value = $encrypted_chars|join:"" }
      }
    }
  }
  response = $result
}
