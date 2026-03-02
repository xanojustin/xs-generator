function "longest_word_in_dictionary_through_deleting" {
  description = "Find the longest word in dictionary that can be formed by deleting characters from s"
  input {
    text s { description = "Source string from which characters can be deleted" }
    text[] d { description = "Array of dictionary words to check" }
  }
  stack {
    // Sort dictionary: first by length descending, then lexicographically ascending
    // This way we can return the first match we find
    var $sorted_dict {
      value = $input.d|sort:{length: "desc", value: "asc"}
    }
    
    // Result will store the longest valid word
    var $result { value = "" }
    
    // Check each word in sorted dictionary
    foreach ($sorted_dict) {
      each as $word {
        // Two-pointer technique to check if word can be formed
        var $s_idx { value = 0 }
        var $w_idx { value = 0 }
        var $s_len { value = $input.s|strlen }
        var $w_len { value = $word|strlen }
        
        // Try to match all characters of word in s (in order)
        while (($s_idx < $s_len) && ($w_idx < $w_len)) {
          each {
            // Get current characters
            var $s_char { value = $input.s|substr:$s_idx:1 }
            var $w_char { value = $word|substr:$w_idx:1 }
            
            conditional {
              if ($s_char == $w_char) {
                // Characters match, advance both pointers
                var.update $w_idx { value = $w_idx + 1 }
              }
            }
            // Always advance s pointer
            var.update $s_idx { value = $s_idx + 1 }
          }
        }
        
        // If we matched all characters of word, we found our answer
        conditional {
          if ($w_idx == $w_len) {
            var.update $result { value = $word }
            // Break out of the loop by setting result
            return { value = $result }
          }
        }
      }
    }
  }
  response = $result
}