function "convert_chunk" {
  description = "Convert a number from 1-999 to English words"
  input {
    int num filters=min:0
    text[] ones
    text[] tens
  }
  stack {
    precondition ($input.num <= 999) {
      error_type = "inputerror"
      error = "Number must be less than or equal to 999"
    }
    
    var $result { value = "" }
    var $n { value = $input.num }
    
    // Handle hundreds
    conditional {
      if ($n >= 100) {
        var $hundreds { value = $n / 100 }
        var $hundreds_idx { value = $hundreds|to_int }
        var $hundreds_word { value = $input.ones|get:$hundreds_idx }
        var $result { value = $result ~ $hundreds_word ~ " Hundred" }
        var $n { value = $n % 100 }
        conditional {
          if ($n > 0) {
            var $result { value = $result ~ " " }
          }
        }
      }
    }
    
    // Handle tens and ones (less than 100)
    conditional {
      if ($n >= 20) {
        // 20-99
        var $ten_digit { value = $n / 10 }
        var $ten_idx { value = $ten_digit|to_int }
        var $ten_word { value = $input.tens|get:$ten_idx }
        var $result { value = $result ~ $ten_word }
        var $ones_digit { value = $n % 10 }
        conditional {
          if ($ones_digit > 0) {
            var $ones_idx { value = $ones_digit|to_int }
            var $ones_word { value = $input.ones|get:$ones_idx }
            var $result { value = $result ~ " " ~ $ones_word }
          }
        }
      }
      elseif ($n > 0) {
        // 1-19
        var $ones_idx { value = $n|to_int }
        var $ones_word { value = $input.ones|get:$ones_idx }
        var $result { value = $result ~ $ones_word }
      }
    }
  }
  response = $result
}
