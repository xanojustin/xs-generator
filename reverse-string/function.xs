function "reverse_string" {
  description = "Reverse a given string"
  input {
    text str filters=trim {
      description = "The string to reverse"
    }
  }
  stack {
    // Split string into array of characters, reverse, then join
    var $chars { value = $input.str|split:"" }
    var $reversed_chars { value = $chars|reverse }
    var $result { value = $reversed_chars|join:"" }
  }
  response = $result
}
