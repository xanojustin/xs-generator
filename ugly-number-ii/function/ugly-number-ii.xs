function "ugly-number-ii" {
  description = "Find the nth ugly number. Ugly numbers are positive numbers whose prime factors only include 2, 3, and 5."
  
  input {
    int n { description = "The position of the ugly number to find (1-indexed)" }
  }
  
  stack {
    // Handle edge cases
    conditional {
      if ($input.n <= 0) {
        return { value = null }
      }
    }
    
    // First ugly number is always 1
    conditional {
      if ($input.n == 1) {
        return { value = 1 }
      }
    }
    
    // Initialize array to store ugly numbers
    var $ugly { value = [1] }
    
    // Three pointers for each prime factor
    var $i2 { value = 0 }
    var $i3 { value = 0 }
    var $i5 { value = 0 }
    
    // Generate ugly numbers until we reach the nth one
    while (($ugly|count) < $input.n) {
      each {
        // Calculate next candidates
        var $next2 { value = $ugly[$i2] * 2 }
        var $next3 { value = $ugly[$i3] * 3 }
        var $next5 { value = $ugly[$i5] * 5 }
        
        // Find the minimum
        var $next_ugly { value = $next2 }
        
        conditional {
          if ($next3 < $next_ugly) {
            var.update $next_ugly { value = $next3 }
          }
        }
        
        conditional {
          if ($next5 < $next_ugly) {
            var.update $next_ugly { value = $next5 }
          }
        }
        
        // Add the next ugly number to our list
        var.update $ugly { value = $ugly|push:$next_ugly }
        
        // Increment pointers that produced this minimum
        conditional {
          if ($next2 == $next_ugly) {
            var.update $i2 { value = $i2 + 1 }
          }
        }
        
        conditional {
          if ($next3 == $next_ugly) {
            var.update $i3 { value = $i3 + 1 }
          }
        }
        
        conditional {
          if ($next5 == $next_ugly) {
            var.update $i5 { value = $i5 + 1 }
          }
        }
      }
    }
    
    // Return the nth ugly number
    return { value = $ugly[($input.n - 1)] }
  }
  
  response = $result
}
