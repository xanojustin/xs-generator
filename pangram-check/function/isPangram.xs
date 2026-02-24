function "is_pangram" {
  description = "Check if a sentence is a pangram (contains every letter of the alphabet at least once)"
  input {
    text text filters=trim { description = "The sentence to check" }
  }
  stack {
    // Convert to lowercase for case-insensitive check
    var $lower_text { value = $input.text|to_lower }
    
    // Remove all non-alphabetic characters (keep only a-z)
    var $letters_only { value = $lower_text|regex_replace:"/[^a-z]/":"" }
    
    // Split into array of individual characters
    var $char_array { value = $letters_only|split:"" }
    
    // Get unique characters using the unique filter
    var $unique_chars { value = $char_array|unique }
    
    // Count unique letters
    var $unique_count { value = ($unique_chars|count) }
    
    // Check if we have all 26 letters of the alphabet
    var $is_pangram { value = $unique_count == 26 }
  }
  response = $is_pangram
}
