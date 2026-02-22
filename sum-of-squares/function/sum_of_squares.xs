// Sum of Squares - Calculate sum of squares of first n natural numbers
// Formula: 1² + 2² + 3² + ... + n² = n(n+1)(2n+1)/6
function "sum_of_squares" {
  description = "Calculates the sum of squares of the first n natural numbers"
  
  input {
    int n { description = "The upper limit (inclusive) for sum of squares calculation" }
  }
  
  stack {
    // Validate input - n must be non-negative
    precondition ($input.n >= 0) {
      error_type = "inputerror"
      error = "Input n must be non-negative"
    }
    
    // Handle edge case of n = 0
    conditional {
      if ($input.n == 0) {
        return { value = 0 }
      }
    }
    
    // Calculate using formula: n(n+1)(2n+1)/6
    // This is more efficient than iterating through all numbers
    var $n { value = $input.n }
    var $n_plus_1 { value = $n + 1 }
    var $two_n_plus_1 { value = (2 * $n) + 1 }
    var $product { value = $n * $n_plus_1 * $two_n_plus_1 }
    var $result { value = $product / 6 }
  }
  
  response = $result
}
