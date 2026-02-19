function "reverse_string" {
  description = "Reverses a given string"
  
  input {
    text? str {
      description = "The string to reverse"
    }
  }
  
  stack {
    // Handle empty/null input - return early with empty string
    conditional {
      if ($input.str == null || $input.str == "") {
        return { value = "" }
      }
    }
    
    // Convert string to array of characters, reverse, and join back
    var $chars { 
      value = $input.str|split:"" 
    }
    
    var $reversed_chars {
      value = $chars|reverse
    }
    
    var $result {
      value = $reversed_chars|join:""
    }
  }
  
  response = $result
}
