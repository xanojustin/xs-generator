function "reverse_words" {
  description = "Reverses each word in a string while maintaining word order"
  input {
    text s { description = "Input string containing words separated by spaces" }
  }
  stack {
    // Split the string into words by spaces
    var $words { value = $input.s|split:" " }
    
    // Map over each word and reverse it by splitting into chars, reversing, and joining
    var $reversed_words { 
      value = $words|map:($$|split:""|reverse|join:"") 
    }
    
    // Join the reversed words back with spaces
    var $result { value = $reversed_words|join:" " }
  }
  response = $result
}
