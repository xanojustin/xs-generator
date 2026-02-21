function "valid_palindrome" {
  description = "Check if a string is a valid palindrome (alphanumeric only, case insensitive)"
  input {
    text text { description = "The string to check" }
  }
  stack {
    // Convert to lowercase
    var $lower_text {
      value = $input.text|to_lower
    }
    
    // Extract only alphanumeric characters using regex
    // Keep only a-z and 0-9 characters
    var $cleaned {
      value = $lower_text|regex_replace:"/[^a-z0-9]/":""
    }
    
    // Reverse the cleaned string by splitting to array, reversing, and joining
    var $reversed {
      value = ($cleaned|split:"")|reverse|join:""
    }
    
    // Check if cleaned string equals its reverse
    var $is_palindrome {
      value = $cleaned == $reversed
    }
  }
  response = $is_palindrome
}
