function "roman_to_integer" {
  description = "Convert a Roman numeral string to an integer"
  
  input {
    text roman {
      description = "Roman numeral string to convert (e.g., 'III', 'IV', 'IX', 'LVIII', 'MCMXCIV')"
    }
  }
  
  stack {
    // Define Roman numeral values as a mapping
    var $values {
      value = {
        I: 1,
        V: 5,
        X: 10,
        L: 50,
        C: 100,
        D: 500,
        M: 1000
      }
    }
    
    // Handle empty string
    conditional {
      if ($input.roman == "" || $input.roman == null) {
        return { value = 0 }
      }
    }
    
    // Initialize result
    var $result {
      value = 0
    }
    
    // Get the length of the input string
    var $length {
      value = $input.roman|strlen
    }
    
    // Iterate through each character
    foreach ((0..($length - 1))) {
      each as $i {
        // Get current character
        var $current_char {
          value = $input.roman|substr:$i:1
        }
        
        // Get current value
        var $current_value {
          value = $values|get:$current_char
        }
        
        // Check if there's a next character
        conditional {
          if ($i < ($length - 1)) {
            // Get next character
            var $next_char {
              value = $input.roman|substr:($i + 1):1
            }
            
            // Get next value
            var $next_value {
              value = $values|get:$next_char
            }
            
            // If current < next, subtract; otherwise add
            conditional {
              if ($current_value < $next_value) {
                var $result {
                  value = $result - $current_value
                }
              }
              else {
                var $result {
                  value = $result + $current_value
                }
              }
            }
          }
          else {
            // Last character - always add
            var $result {
              value = $result + $current_value
            }
          }
        }
      }
    }
  }
  
  response = $result
}
