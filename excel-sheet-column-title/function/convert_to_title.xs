function "convert_to_title" {
  input {
    int column_number
  }

  stack {
    // Array of letters A-Z for indexing
    var $letters { value = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"] }
    var $result { value = "" }
    var $n { value = $input.column_number }

    while ($n > 0) {
      each {
        var $remainder { value = ($n - 1) % 26 }
        var $char { value = $letters[$remainder] }
        var.update $result { value = $char ~ $result }
        var.update $n { value = ($n - 1) / 26 }
      }
    }
  }

  response = $result
}
