function "di_string_match" {
  description = "Find a valid permutation for DI string pattern"
  input {
    text pattern filters=trim
  }
  stack {
    // Get length of pattern and initialize variables
    var $n { value = ($input.pattern|strlen) }
    var $low { value = 0 }
    var $high { value = $n }
    var $result { value = [] }
    var $i { value = 0 }

    // Process each character in the pattern
    while ($i < $n) {
      each {
        // Get character at position i
        var $char { value = $input.pattern|substr:$i:1 }
        
        conditional {
          if ($char == "I") {
            // For 'I', use the lowest available number (it will increase)
            var.update $result { value = $result|append:$low }
            var.update $low { value = $low + 1 }
          }
          else {
            // For 'D', use the highest available number (it will decrease)
            var.update $result { value = $result|append:$high }
            var.update $high { value = $high - 1 }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }

    // Add the final remaining number
    var.update $result { value = $result|append:$low }
  }
  response = $result
}
