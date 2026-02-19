// Reverses a given string and returns the result
function "reverse_string" {
  description = "Reverses the input string"
  
  input {
    text input_string
  }
  
  stack {
    // Convert string to array of characters, reverse, then join back
    var $reversed {
      value = $input.input_string|split:""|reverse|join:""
    }
  }
  
  response = $reversed
}
