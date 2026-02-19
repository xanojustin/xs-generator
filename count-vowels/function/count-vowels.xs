function "count-vowels" {
  description = "Count the number of vowels in a given string"
  
  input {
    text text filters=lower {
      description = "The input string to count vowels in"
    }
  }
  
  stack {
    var $vowels { value = ["a", "e", "i", "o", "u"] }
    var $count { value = 0 }
    var $index { value = 0 }
    var $text_length { value = $input.text|strlen }
    
    while ($index < $text_length) {
      each {
        var $char { value = $input.text|substr:$index:1 }
        
        conditional {
          if (`$char == "a" || $char == "e" || $char == "i" || $char == "o" || $char == "u"`) {
            var.update $count { value = $count + 1 }
          }
        }
        
        var.update $index { value = $index + 1 }
      }
    }
  }
  
  response = {
    text: $input.text
    vowel_count: $count
  }
}
