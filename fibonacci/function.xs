function "fibonacci" {
  description = "Generate the first n Fibonacci numbers"
  input {
    int n filters=min:1|max:50 {
      description = "The number of Fibonacci numbers to generate (must be >= 1, max 50 to prevent overflow)"
    }
  }
  stack {
    // Handle first Fibonacci number
    conditional {
      if ($input.n == 1) {
        var $result { value = [0] }
      }
      else {
        // Initialize with first two Fibonacci numbers
        var $result { value = [0, 1] }
        var $i { value = 2 }

        while ($i < $input.n) {
          each {
            // Calculate next Fibonacci number as sum of previous two
            var $next_fib { 
              value = $result[($i - 1)] + $result[($i - 2)] 
            }
            var.update $result { 
              value = $result|push:$next_fib 
            }
            var.update $i { value = $i + 1 }
          }
        }
      }
    }
  }
  response = $result
}
