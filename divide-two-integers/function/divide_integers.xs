// Divide Two Integers - Classic coding exercise
// Divide two integers without using multiplication, division, or mod operators
// Uses bit manipulation (binary long division) for efficient computation
function "divide_integers" {
  description = "Divides two integers without using multiplication, division, or mod operators"
  
  input {
    int dividend { description = "The number to be divided" }
    int divisor { description = "The number to divide by (non-zero)" }
  }
  
  stack {
    // Handle edge case: divisor is zero
    precondition ($input.divisor != 0) {
      error_type = "standard"
      error = "Divisor cannot be zero"
    }
    
    var $final_result { value = 0 }
    
    // Handle edge case: integer overflow (MIN_INT / -1)
    conditional {
      if ($input.dividend == -2147483648 && $input.divisor == -1) {
        var $final_result { value = 2147483647 }
      }
      else {
        // Determine if result should be negative
        var $is_negative {
          value = ($input.dividend < 0) != ($input.divisor < 0)
        }
        
        // Work with positive values using absolute values
        var $dvd { 
          value = $input.dividend < 0 ? 0 - $input.dividend : $input.dividend
        }
        var $dvs {
          value = $input.divisor < 0 ? 0 - $input.divisor : $input.divisor
        }
        
        var $quotient { value = 0 }
        
        // Binary long division approach
        while ($dvd >= $dvs) {
          each {
            var $temp { value = $dvs }
            var $multiple { value = 1 }
            
            // Find the largest double that fits
            while ($dvd >= ($temp + $temp)) {
              each {
                var $temp { value = $temp + $temp }
                var $multiple { value = $multiple + $multiple }
              }
            }
            
            var $dvd { value = $dvd - $temp }
            var $quotient { value = $quotient + $multiple }
          }
        }
        
        // Apply sign to result
        conditional {
          if ($is_negative) {
            var $quotient { value = 0 - $quotient }
          }
        }
        
        var $final_result { value = $quotient }
      }
    }
  }
  
  response = $final_result
}
