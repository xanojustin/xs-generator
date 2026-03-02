// Mirror Reflection - Geometry problem
// Returns the receptor number hit by a laser in a mirrored square room
function "mirror_reflection" {
  description = "Finds which receptor a laser beam hits first in a mirrored square room"
  
  input {
    int p { description = "Length of the square room walls" }
    int q { description = "Distance from receptor 0 where laser first hits east wall" }
  }
  
  stack {
    // Validate inputs
    precondition ($input.p > 0 && $input.q > 0 && $input.q <= $input.p) {
      error_type = "inputerror"
      error = "p and q must be positive, and q must be <= p"
    }
    // Calculate GCD using Euclidean algorithm
    var $a { value = $input.p }
    var $b { value = $input.q }
    
    while ($b != 0) {
      each {
        var $temp { value = $b }
        var.update $b { value = $a % $b }
        var.update $a { value = $temp }
      }
    }
    
    var $gcd { value = $a }
    // Reduce to simplest form
    var $reduced_p { value = $input.p / $gcd }
    var $reduced_q { value = $input.q / $gcd }
    // Determine receptor based on parity
    var $receptor { value = -1 }
    
    conditional {
      if (`$reduced_p % 2 == 0`) {
        var.update $receptor { value = 2 }
      }
      elseif (`$reduced_q % 2 == 0`) {
        var.update $receptor { value = 0 }
      }
      else {
        var.update $receptor { value = 1 }
      }
    }
  }
  
  response = $receptor
}
