// Helper function for fast exponentiation using divide and conquer
function "fast_pow" {
  description = "Recursive helper for fast exponentiation"
  
  input {
    decimal base { description = "The base number" }
    int exp { description = "The exponent (non-negative)" }
  }
  
  stack {
    conditional {
      // Base case: anything^0 = 1
      if ($input.exp == 0) {
        var $result { 
          value = 1.0 
        }
      }
      // If exp is even: x^n = (x^2)^(n/2)
      elseif (`$input.exp % 2 == 0`) {
        function.run "fast_pow" {
          input = {
            base: ($input.base * $input.base)
            exp: ($input.exp / 2)
          }
        } as $half_pow
        var $result { 
          value = $half_pow 
        }
      }
      // If exp is odd: x^n = x * x^(n-1)
      else {
        function.run "fast_pow" {
          input = {
            base: $input.base
            exp: ($input.exp - 1)
          }
        } as $sub_pow
        var $result { 
          value = $input.base * $sub_pow 
        }
      }
    }
  }
  
  response = $result
}
