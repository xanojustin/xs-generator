function "factorial" {
  description = "Calculate the factorial of a non-negative integer"
  input {
    int n filters=min:0|max:20 {
      description = "The non-negative integer to calculate factorial for (max 20 to prevent overflow)"
    }
  }
  stack {
    // Handle base case: 0! = 1
    conditional {
      if ($input.n == 0 || $input.n == 1) {
        var $result { value = 1 }
      }
      else {
        // Iterative calculation for n > 1
        var $result { value = 1 }
        var $i { value = 2 }

        while ($i <= $input.n) {
          each {
            var.update $result { value = $result * $i }
            var.update $i { value = $i + 1 }
          }
        }
      }
    }
  }
  response = $result
}
