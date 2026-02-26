function "is_armstrong_number" {
  description = "Check if a number is an Armstrong number"
  input {
    int number filters=min:0
  }
  stack {
    // Handle edge case: 0 is an Armstrong number (0^1 = 0)
    conditional {
      if ($input.number == 0) {
        return { value = true }
      }
    }

    // Convert number to string to process digits
    var $num_text { value = $input.number|to_text }
    var $num_digits { value = $num_text|strlen }
    var $sum { value = 0 }
    var $temp { value = $input.number }

    // Extract digits and calculate sum of powers
    while ($temp > 0) {
      each {
        var $digit { value = $temp % 10 }
        var $power { value = $digit|pow:$num_digits }
        var.update $sum { value = $sum + $power }
        var.update $temp { value = $temp / 10 }
      }
    }

    // Check if sum equals original number
    var $is_armstrong { value = $sum == $input.number }
  }
  response = $is_armstrong
}
