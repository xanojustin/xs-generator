function "is_subsequence" {
  description = "Check if string s is a subsequence of string t"
  input {
    text s { description = "The potential subsequence string" }
    text t { description = "The target string to check against" }
  }
  stack {
    var $s_index { value = 0 }
    var $s_length { value = ($input.s|strlen) }
    var $t_length { value = ($input.t|strlen) }
    
    // Empty string is a subsequence of any string
    conditional {
      if ($s_length == 0) {
        return { value = true }
      }
    }
    
    // Iterate through t using while loop with index tracking
    var $t_index { value = 0 }
    
    while ($t_index < $t_length && $s_index < $s_length) {
      each {
        // Get current character from t using substr
        var $t_char {
          value = $input.t|substr:$t_index:$t_index+1
        }
        
        // Get current character from s using substr
        var $s_char {
          value = $input.s|substr:$s_index:$s_index+1
        }
        
        conditional {
          if ($t_char == $s_char) {
            // Characters match, move s pointer
            math.add $s_index { value = 1 }
          }
        }
        
        // Always move t pointer
        math.add $t_index { value = 1 }
      }
    }
    
    // If we've matched all characters in s, it's a subsequence
    conditional {
      if ($s_index == $s_length) {
        return { value = true }
      }
    }
  }
  response = false
}
