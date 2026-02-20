function "is_palindrome" {
  description = "Check if a string is a palindrome (reads the same forwards and backwards)"
  input {
    text text filters=trim { description = "The string to check" }
  }
  stack {
    // Convert to lowercase for case-insensitive comparison
    var $lower_text { value = $input.text|to_lower }
    
    // Remove non-alphanumeric characters
    var $cleaned { value = $lower_text|regex_replace:"/[^a-z0-9]/":"" }
    
    // Split into array of characters, reverse, and join back
    var $char_array { value = $cleaned|split:"" }
    var $reversed_array { value = $char_array|reverse }
    var $reversed { value = $reversed_array|join:"" }
    
    // Check if cleaned text equals reversed text
    var $is_palindrome { value = $cleaned == $reversed }
  }
  response = $is_palindrome
}