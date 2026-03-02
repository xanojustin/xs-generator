function "valid_word_abbreviation" {
  input {
    text word
    text abbr
  }
  
  stack {
    var $word_len { value = $input.word|strlen }
    var $abbr_len { value = $input.abbr|strlen }
    var $word_idx { value = 0 }
    var $abbr_idx { value = 0 }
    var $is_valid { value = true }
    
    while ($word_idx < $word_len && $abbr_idx < $abbr_len) {
      each {
        var $abbr_char { value = $input.abbr|substr:$abbr_idx:1 }
        
        // Check if current char in abbr is a digit
        conditional {
          if ($abbr_char >= "0" && $abbr_char <= "9") {
            // Leading zero is not allowed
            conditional {
              if ($abbr_char == "0") {
                var.update $is_valid { value = false }
              }
            }
            
            // Parse the full number
            var $num { value = 0 }
            while ($abbr_idx < $abbr_len) {
              each {
                var $digit_char { value = $input.abbr|substr:$abbr_idx:1 }
                conditional {
                  if ($digit_char >= "0" && $digit_char <= "9") {
                    var.update $num { value = ($num * 10) + ($digit_char|to_int) }
                    var.update $abbr_idx { value = $abbr_idx + 1 }
                  }
                  else {
                    return { value = "break" }
                  }
                }
              }
            }
            
            // Skip $num characters in word
            var.update $word_idx { value = $word_idx + $num }
          }
          else {
            // Character must match
            var $word_char { value = $input.word|substr:$word_idx:1 }
            conditional {
              if ($word_char != $abbr_char) {
                var.update $is_valid { value = false }
              }
            }
            var.update $word_idx { value = $word_idx + 1 }
            var.update $abbr_idx { value = $abbr_idx + 1 }
          }
        }
      }
    }
    
    // Check if we've consumed both strings completely
    conditional {
      if ($word_idx != $word_len || $abbr_idx != $abbr_len) {
        var.update $is_valid { value = false }
      }
    }
  }
  
  response = $is_valid
}
