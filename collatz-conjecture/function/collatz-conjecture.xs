function "collatz-conjecture" {
  description = "Calculate the number of steps to reach 1 using the Collatz conjecture rules"
  
  input {
    int n { description = "Starting positive integer" }
  }
  
  stack {
    var $steps { value = 0 }
    var $current { value = $input.n }
    
    // Handle edge case: n must be positive
    precondition ($input.n > 0) {
      error_type = "inputerror"
      error = "Input must be a positive integer"
    }
    
    // Collatz process: repeatedly apply rules until we reach 1
    while ($current > 1) {
      each {
        conditional {
          // If even, divide by 2
          if (($current % 2) == 0) {
            var.update $current { value = $current / 2 }
          }
          // If odd, multiply by 3 and add 1
          else {
            var.update $current { value = ($current * 3) + 1 }
          }
        }
        var.update $steps { value = $steps + 1 }
      }
    }
  }
  
  response = $steps
}
