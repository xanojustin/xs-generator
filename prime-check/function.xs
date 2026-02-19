function "is_prime" {
  description = "Check if a given integer is a prime number"
  input {
    int n {
      description = "The integer to check for primality"
    }
  }
  stack {
    // Numbers less than 2 are not prime
    conditional {
      if ($input.n < 2) {
        var $result { value = false }
      }
      elseif ($input.n == 2) {
        // 2 is the only even prime number
        var $result { value = true }
      }
      elseif ($input.n % 2 == 0) {
        // Even numbers greater than 2 are not prime
        var $result { value = false }
      }
      else {
        // Check odd divisors from 3 up to sqrt(n)
        var $result { value = true }
        var $i { value = 3 }
        var $limit { value = ($input.n|sqrt)|floor }

        while ($i <= $limit && $result == true) {
          each {
            conditional {
              if ($input.n % $i == 0) {
                var.update $result { value = false }
              }
            }
            var.update $i { value = $i + 2 }
          }
        }
      }
    }
  }
  response = $result
}
