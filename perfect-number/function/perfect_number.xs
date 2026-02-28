function "perfect_number" {
  input {
    int number
  }
  
  stack {
    // Validate input: must be positive
    precondition ($input.number > 0) {
      error_type = "inputerror"
      error = "Number must be positive"
    }
    
    // Edge case: 1 is not a perfect number
    conditional {
      if ($input.number == 1) {
        return { value = false }
      }
    }
    
    // Calculate sum of proper divisors
    // Start with 1 since 1 is always a divisor
    var $sum { value = 1 }
    var $i { value = 2 }
    
    // Only need to check up to sqrt(number)
    var $sqrt_n { value = ($input.number|sqrt)|floor }
    
    while ($i <= $sqrt_n) {
      each {
        conditional {
          if (($input.number % $i) == 0) {
            // $i is a divisor
            var.update $sum { value = $sum + $i }
            
            // Add the corresponding divisor (number/i) if it's different
            var $other_divisor { value = $input.number / $i }
            conditional {
              if ($other_divisor != $i) {
                var.update $sum { value = $sum + $other_divisor }
              }
            }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Check if sum of divisors equals the number
    var $is_perfect { value = ($sum == $input.number) }
  }
  
  response = $is_perfect
}
