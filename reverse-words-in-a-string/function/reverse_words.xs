// Reverse Words in a String - Classic coding exercise
// Reverses the order of words in a string, handling multiple spaces
// Words are separated by spaces; leading/trailing/excess spaces are trimmed
function "reverse_words" {
  description = "Reverses the order of words in a string"
  
  input {
    text input_string { description = "The string to reverse words in" }
  }
  
  stack {
    // Trim leading/trailing whitespace and split by whitespace
    var $trimmed {
      value = $input.input_string|trim
    }
    
    // Split into words (handles multiple spaces automatically)
    var $words {
      value = $trimmed|split:" "
    }
    
    // Filter out empty strings that result from multiple spaces
    var $filtered_words {
      value = $words|filter:($this != "")
    }
    
    // Reverse the array of words
    var $reversed {
      value = $filtered_words|reverse
    }
    
    // Join back with single spaces
    var $result {
      value = $reversed|join:" "
    }
  }
  
  response = $result
}
