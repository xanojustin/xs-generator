// Factorial - Classic math coding exercise
// Calculates the factorial of a non-negative integer n
// Factorial: n! = n × (n-1) × (n-2) × ... × 1, with 0! = 1
function "factorial" {
  description = "Calculates the factorial of a non-negative integer"
  
  input {
    int n { description = "Non-negative integer to calculate factorial for" }
  }
  
  stack {
    // Handle negative input - factorial is undefined for negative numbers
    precondition ($input.n >= 0) {
      error_type = "standard"
      error = "Factorial is not defined for negative numbers"
    }
    
    // Base case: 0! = 1 and 1! = 1
    conditional {
      if ($input.n <= 1) {
        var $result { value = 1 }
      }
      else {
        // Iterative approach to calculate factorial
        var $result { value = 1 }
        var $i { value = 2 }
        
        while ($i <= $input.n) {
          each {
            var $result { value = $result * $i }
            var.update $i { value = $i + 1 }
          }
        }
      }
    }
  }
  
  response = $result
}
