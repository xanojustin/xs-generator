// Pow(x, n) - Calculate x raised to the power n
// Implements fast exponentiation (divide and conquer) for O(log n) complexity
function "pow_x_n" {
  description = "Calculates x raised to the power n using fast exponentiation"
  
  input {
    decimal x { description = "The base number" }
    int n { description = "The exponent (can be negative)" }
  }
  
  stack {
    // Handle negative exponents: x^(-n) = 1/(x^n)
    conditional {
      if ($input.n < 0) {
        var $neg_exp { 
          value = true 
        }
        var $exp { 
          value = $input.n * -1 
        }
      }
      else {
        var $neg_exp { 
          value = false 
        }
        var $exp { 
          value = $input.n 
        }
      }
    }
    
    // Call recursive helper function for fast exponentiation
    function.run "fast_pow" {
      input = {
        base: $input.x
        exp: $exp
      }
    } as $result
    
    // Handle negative exponent result
    conditional {
      if ($neg_exp) {
        var $final_result { 
          value = 1.0 / $result 
        }
      }
      else {
        var $final_result { 
          value = $result 
        }
      }
    }
  }
  
  response = $final_result
}
