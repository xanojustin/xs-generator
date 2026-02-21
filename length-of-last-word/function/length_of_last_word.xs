// Length of Last Word - String manipulation exercise
// Given a string s consisting of words and spaces, return the length of the last word
// A word is a maximal substring consisting of non-space characters only
function "length_of_last_word" {
  description = "Returns the length of the last word in a string"
  
  input {
    text s { description = "String consisting of words and spaces" }
  }
  
  stack {
    // Trim trailing spaces first
    var $trimmed { value = $input.s|rtrim }
    
    // Split the string by spaces to get words
    var $words { value = $trimmed|split:" " }
    
    // Get the last word
    var $last_word { value = $words|last }
    
    // Return the length of the last word
    var $length { value = $last_word|strlen }
  }
  
  response = $length
}
