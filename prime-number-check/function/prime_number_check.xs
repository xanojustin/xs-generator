// Prime Number Check - Determines if a given number is prime
// A prime number is a natural number greater than 1 that has no positive divisors other than 1 and itself
function "prime_number_check" {
  description = "Checks if a given integer is a prime number"
  
  input {
    int n { description = "The number to check for primality" }
  }
  
  stack {
    // Handle edge cases: numbers less than 2 are not prime
    conditional {
      if ($input.n < 2) {
        var $is_prime { value = false }
      }
      elseif ($input.n == 2) {
        // 2 is the only even prime number
        var $is_prime { value = true }
      }
      elseif (`$input.n % 2 == 0`) {
        // Even numbers greater than 2 are not prime
        var $is_prime { value = false }
      }
      else {
        // Check odd divisors from 3 up to the square root of n
        var $is_prime { value = true }
        var $divisor { value = 3 }
        
        // Calculate square root using filter
        var $sqrt_n { value = ($input.n|sqrt)|floor }
        
        while ($divisor <= $sqrt_n) {
          each {
            conditional {
              if (`$input.n % $divisor == 0`) {
                // Found a divisor, not prime
                var $is_prime { value = false }
                // Exit loop early by setting divisor higher than sqrt_n
                var $divisor { value = $sqrt_n + 1 }
              }
              else {
                // Check next odd number
                var $divisor { value = $divisor + 2 }
              }
            }
          }
        }
      }
    }
  }
  
  response = $is_prime
}
