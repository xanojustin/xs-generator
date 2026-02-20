function "fibonacci" {
  description = "Calculate the nth Fibonacci number"
  
  input {
    int n { description = "The position in the Fibonacci sequence (0-indexed)" }
  }
  
  stack {
    // Handle edge cases
    conditional {
      if (`$input.n <= 0`) {
        return { value = 0 }
      }
      elseif (`$input.n == 1`) {
        return { value = 1 }
      }
    }
    
    // Iterative approach for efficiency
    var $prev { value = 0 }
    var $curr { value = 1 }
    var $i { value = 2 }
    
    while (`$i <= $input.n`) {
      each {
        var $next { value = $prev + $curr }
        var.update $prev { value = $curr }
        var.update $curr { value = $next }
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $curr
}
