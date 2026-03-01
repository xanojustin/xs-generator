// Fraction Addition - Add/subtract fractions from a string expression
// Parses expressions like "-1/2+1/2+1/3" and returns the sum as a reduced fraction
function "fraction_addition" {
  description = "Adds/subtracts fractions from a string expression and returns the reduced result"
  
  input {
    text expression { description = "Fraction expression like '-1/2+1/2+1/3'" }
  }
  
  stack {
    // Parse the expression into individual fractions
    var $fractions { value = [] }
    var $current { value = "" }
    var $i { value = 0 }
    var $len { value = $input.expression|strlen }
    
    // Handle first character if it's a negative sign
    conditional {
      if ($len > 0 && $input.expression|substr:0:1 == "-") {
        var $current { value = "-" }
        var $i { value = 1 }
      }
    }
    
    // Parse fractions from the expression
    while ($i < $len) {
      each {
        var $char { value = $input.expression|substr:$i:1 }
        
        conditional {
          if ($char == "+" || $char == "-") {
            // Save previous fraction if exists
            conditional {
              if (($current|strlen) > 0) {
                var $fractions {
                  value = $fractions|merge:[$current]
                }
              }
            }
            var $current { value = $char }
          }
          else {
            var $current { value = $current ~ $char }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
    
    // Add the last fraction
    conditional {
      if (($current|strlen) > 0) {
        var $fractions {
          value = $fractions|merge:[$current]
        }
      }
    }
    
    // Calculate the result
    var $total_num { value = 0 }
    var $total_den { value = 1 }
    
    // Sum all fractions
    foreach ($fractions) {
      each as $fraction {
        // Parse numerator and denominator
        var $parts { value = $fraction|split:"/" }
        var $num_str { value = $parts|first }
        var $den_str { value = $parts|last }
        
        var $num { value = $num_str|to_int }
        var $den { value = $den_str|to_int }
        
        // Add to total: a/b + c/d = (a*d + c*b) / (b*d)
        var $total_num {
          value = ($total_num * $den) + ($num * $total_den)
        }
        var $total_den {
          value = $total_den * $den
        }
      }
    }
    
    // Calculate GCD for reduction
    var $a { value = $total_num|abs }
    var $b { value = $total_den }
    
    conditional {
      if ($a == 0) {
        var $gcd { value = $b }
      }
      else {
        while ($b != 0) {
          each {
            var $temp { value = $b }
            var $b { value = $a % $b }
            var $a { value = $temp }
          }
        }
        var $gcd { value = $a }
      }
    }
    
    // Reduce the fraction
    var $reduced_num { value = $total_num / $gcd }
    var $reduced_den { value = $total_den / $gcd }
    
    // Handle negative denominator
    conditional {
      if ($reduced_den < 0) {
        var $reduced_num { value = $reduced_num * -1 }
        var $reduced_den { value = $reduced_den * -1 }
      }
    }
    
    // Format result
    var $result {
      value = ($reduced_num|to_text) ~ "/" ~ ($reduced_den|to_text)
    }
  }
  
  response = $result
}
