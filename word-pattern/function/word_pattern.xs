function "word_pattern" {
  description = "Check if a pattern matches a string following a bijection mapping"
  input {
    text pattern { description = "The pattern string (e.g., 'abba')" }
    text s { description = "The string of space-separated words (e.g., 'dog cat cat dog')" }
  }
  stack {
    // Result variable - assume true until proven false
    var $result { value = true }
    
    // Split the string into words array
    var $words { value = $input.s|split:" " }
    
    // Split the pattern into characters array
    var $pattern_chars { value = $input.pattern|split:"" }
    
    // Check if lengths match
    var $pattern_length { value = ($pattern_chars|count) }
    var $words_count { value = ($words|count) }
    
    conditional {
      if ($pattern_length != $words_count) {
        var.update $result { value = false }
      }
    }
    
    // Only continue if result is still true
    conditional {
      if ($result == true) {
        // Create maps for pattern to word and word to pattern
        var $pattern_to_word { value = {} }
        var $word_to_pattern { value = {} }
        
        // Iterate through each character and word
        var $index { value = 0 }
        
        conditional {
          if (($pattern_length) > 0) {
            foreach ($pattern_chars) {
              each as $char {
                // Get the current word
                var $current_word { value = $words|get:$index }
                
                // Check if pattern char already mapped to a different word
                conditional {
                  if (($pattern_to_word|has:$char)) {
                    var $mapped_word { value = $pattern_to_word|get:$char }
                    conditional {
                      if ($mapped_word != $current_word) {
                        var.update $result { value = false }
                      }
                    }
                  }
                }
                
                // Only continue if result is still true
                conditional {
                  if ($result == true) {
                    // Check if word already mapped to a different pattern char
                    conditional {
                      if (($word_to_pattern|has:$current_word)) {
                        var $mapped_char { value = $word_to_pattern|get:$current_word }
                        conditional {
                          if ($mapped_char != $char) {
                            var.update $result { value = false }
                          }
                        }
                      }
                    }
                  }
                }
                
                // Only update maps if result is still true
                conditional {
                  if ($result == true) {
                    // Create the mappings
                    var $pattern_to_word { value = $pattern_to_word|set:$char:$current_word }
                    var $word_to_pattern { value = $word_to_pattern|set:$current_word:$char }
                  }
                }
                
                // Increment index
                var.update $index { value = $index|add:1 }
              }
            }
          }
        }
      }
    }
  }
  response = $result
}
