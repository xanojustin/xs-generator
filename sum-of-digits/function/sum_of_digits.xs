function "sum_of_digits" {
  description = "Calculate the sum of all digits in a given integer"
  input {
    int number { description = "The integer whose digits will be summed" }
  }
  stack {
    var $sum { value = 0 }
    var $n { value = $input.number }
    
    // Handle negative numbers by taking absolute value
    conditional {
      if ($n < 0) {
        var.update $n { value = $n * -1 }
      }
    }
    
    // Loop to extract and sum each digit
    while ($n > 0) {
      each {
        // Get the last digit using modulo
        var $digit { value = $n % 10 }
        
        // Add digit to sum
        math.add $sum { value = $digit }
        
        // Remove the last digit by integer division
        var.update $n { value = $n / 10 }
      }
    }
  }
  response = $sum
}
