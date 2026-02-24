function "detect-capital" {
  description = "Detects if capital letters are used correctly in a word"
  input {
    text word { description = "The word to check for correct capital usage" }
  }
  stack {
    // Get the word and check its properties
    var $word_upper { value = $input.word|to_upper }
    var $word_lower { value = $input.word|to_lower }
    var $first_char { value = $input.word|substr:0:1 }
    var $rest { value = $input.word|substr:1 }
    var $rest_lower { value = $rest|to_lower }
    
    // Check if all capitals
    var $is_all_upper { value = $input.word == $word_upper }
    
    // Check if all lowercase
    var $is_all_lower { value = $input.word == $word_lower }
    
    // Check if only first is capital (first char is uppercase, rest is lowercase)
    var $first_upper { value = $first_char|to_upper }
    var $is_first_capital { value = $first_char == $first_upper && $rest == $rest_lower }
    
    // Valid if any of the three conditions are true
    var $is_valid {
      value = $is_all_upper || $is_all_lower || $is_first_capital
    }
  }
  response = $is_valid
}
