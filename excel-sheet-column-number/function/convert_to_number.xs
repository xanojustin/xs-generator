function "convert_to_number" {
  input {
    text column_title filters=trim|upper
  }

  stack {
    // Array of letters A-Z for reverse lookup (index 0 = A, which equals 1)
    var $letters { value = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"] }
    var $result { value = 0 }
    var $title { value = $input.column_title }
    var $length { value = $title|strlen }
    var $i { value = 0 }

    while ($i < $length) {
      each {
        // Get the character at position $i
        var $char { value = $title|substr:$i:1 }
        // Find index of the character in letters array (A=0, B=1, etc.)
        // Then add 1 to get the value (A=1, B=2, etc.)
        var $char_index { value = ($letters|findIndex:$$ == $char) + 1 }
        // Accumulate: result = result * 26 + char_value
        // This handles the base-26 nature of Excel columns
        var.update $result { value = ($result * 26) + $char_index }
        var.update $i { value = $i + 1 }
      }
    }
  }

  response = $result
}
