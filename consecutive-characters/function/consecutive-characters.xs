// Consecutive Characters - Find the power of a string
// The power is the maximum length of a non-empty substring containing only one unique character
function "consecutive-characters" {
  description = "Finds the maximum length of consecutive repeating characters in a string"
  
  input {
    text s { description = "Input string to analyze" }
  }
  
  stack {
    // Handle empty string edge case
    conditional {
      if (($input.s|strlen) == 0) {
        return { value = 0 }
      }
    }
    
    // Initialize tracking variables
    var $max_power { value = 1 }
    var $current_power { value = 1 }
    var $i { value = 1 }
    
    // Iterate through the string starting from the second character
    while ($i < ($input.s|strlen)) {
      each {
        // Get current and previous characters
        var $current_char { value = $input.s|substr:$i:1 }
        var $prev_char { value = $input.s|substr:($i - 1):1 }
        
        // Check if characters match
        conditional {
          if ($current_char == $prev_char) {
            // Same character - extend current streak
            var.update $current_power { value = $current_power + 1 }
            
            // Update max if current streak is longer
            conditional {
              if ($current_power > $max_power) {
                var.update $max_power { value = $current_power }
              }
            }
          }
          else {
            // Different character - reset current streak
            var.update $current_power { value = 1 }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $max_power
}
