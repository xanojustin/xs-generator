function "reverse_string" {
  description = "Reverse a given string. Returns the characters in reverse order."
  
  input {
    text text filters=trim
  }
  
  stack {
    // Use the reverse filter to reverse the string
    var $reversed { value = $input.text|reverse }
  }
  
  response = {
    original: $input.text,
    reversed: $reversed
  }
}