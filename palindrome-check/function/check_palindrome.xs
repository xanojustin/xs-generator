function "check_palindrome" {
  description = "Check if a given string is a palindrome (reads the same forwards and backwards). Ignores case, spaces, and punctuation."
  
  input {
    text text filters=trim
  }
  
  stack {
    // Convert to lowercase for case-insensitive comparison
    var $lowercase_text { value = $input.text|to_lower }
    
    // Remove all non-alphanumeric characters
    var $cleaned_text { value = $lowercase_text|regex_replace:"[^a-z0-9]":"" }
    
    // Get the length of the cleaned text
    var $length { value = $cleaned_text|count }
    
    // Handle edge cases: empty string or single character is a palindrome
    conditional {
      if ($length <= 1) {
        var $is_palindrome { value = true }
      }
      else {
        // Reverse the cleaned text
        var $reversed_text { value = $cleaned_text|reverse }
        
        // Compare original cleaned text with reversed
        var $is_palindrome { value = $cleaned_text == $reversed_text }
      }
    }
  }
  
  response = {
    input: $input.text,
    cleaned: $cleaned_text,
    is_palindrome: $is_palindrome,
    length: $length
  }
}
