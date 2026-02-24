// Removes all vowels from a given string
function "remove_vowels" {
  description = "Removes all vowels (a, e, i, o, u) from the input string, both uppercase and lowercase"
  
  input {
    text input_string
  }
  
  stack {
    // Convert input string to array of characters
    var $chars {
      value = $input.input_string|split:""
    }
    
    // Initialize result array
    var $result_chars {
      value = []
    }
    
    // Iterate through each character
    foreach ($chars) {
      each as $char {
        // Flag to track if character is a vowel
        var $is_vowel { value = false }
        
        // Check lowercase vowels
        conditional {
          if ($char == "a" || $char == "e" || $char == "i" || $char == "o" || $char == "u") {
            var $is_vowel { value = true }
          }
        }
        
        // Check uppercase vowels
        conditional {
          if ($char == "A" || $char == "E" || $char == "I" || $char == "O" || $char == "U") {
            var $is_vowel { value = true }
          }
        }
        
        // If not a vowel, add to result
        conditional {
          if ($is_vowel == false) {
            var $result_chars {
              value = $result_chars ~ [$char]
            }
          }
        }
      }
    }
    
    // Join the result array back into a string
    var $result {
      value = $result_chars|join:""
    }
  }
  
  response = $result
}
