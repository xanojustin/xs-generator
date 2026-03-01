function "is_isogram" {
  description = "Check if a word or phrase is an isogram (no repeating letters)"
  input {
    text text filters=trim { description = "The word or phrase to check" }
  }
  stack {
    // Convert to lowercase for case-insensitive comparison
    var $lower_text { value = $input.text|to_lower }
    
    // Remove all non-alphabetic characters (keep only a-z)
    var $letters_only { value = $lower_text|regex_replace:"/[^a-z]/":"" }
    
    // Split into array of individual characters
    var $char_array { value = $letters_only|split:"" }
    
    // Get unique characters
    var $unique_chars { value = $char_array|unique }
    
    // Count total letters and unique letters
    var $total_count { value = ($char_array|count) }
    var $unique_count { value = ($unique_chars|count) }
    
    // Isogram if total equals unique (no duplicates)
    var $is_isogram { value = $total_count == $unique_count }
  }
  response = $is_isogram
}
