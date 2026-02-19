function "fibonacci" {
  description = "Generate the first n Fibonacci numbers"
  
  input {
    int n {
      description = "The number of Fibonacci numbers to generate"
    }
  }
  
  stack {
    // Handle edge case: n less than 1
    conditional {
      if ($input.n < 1) {
        return { value = [] }
      }
    }
    
    // Handle base case: n = 1
    conditional {
      if ($input.n == 1) {
        return { value = [0] }
      }
    }
    
    // Initialize with first two Fibonacci numbers
    var $result {
      value = [0, 1]
    }
    
    // Generate remaining Fibonacci numbers
    // Start from index 2 since we already have F(0) and F(1)
    foreach ((2..($input.n - 1))) {
      each as $i {
        // Get previous two numbers
        var $prev1 {
          value = $result|get:($i - 1)
        }
        var $prev2 {
          value = $result|get:($i - 2)
        }
        
        // Calculate next Fibonacci number
        var $next {
          value = $prev1 + $prev2
        }
        
        // Add to result array
        var $result {
          value = $result|push:$next
        }
      }
    }
  }
  
  response = $result
}
