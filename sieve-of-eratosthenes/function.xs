function "sieve_of_eratosthenes" {
  description = "Find all prime numbers up to n using the Sieve of Eratosthenes algorithm"
  input {
    int n filters=min:2|max:100000 {
      description = "The upper limit for finding primes (must be >= 2)"
    }
  }
  stack {
    // Initialize array where index represents the number
    // true = potentially prime, false = not prime
    var $is_prime { value = [] }
    var $i { value = 0 }
    
    // Initialize all values to true from 0 to n
    while ($i <= $input.n) {
      each {
        var $is_prime { value = $is_prime|push:true }
        var.update $i { value = $i + 1 }
      }
    }
    
    // 0 and 1 are not prime
    var.update $is_prime { value = $is_prime|set:0:false }
    var.update $is_prime { value = $is_prime|set:1:false }
    
    // Sieve: mark multiples of each prime as not prime
    var $p { value = 2 }
    while ($p * $p <= $input.n) {
      each {
        conditional {
          // If p is still marked as prime
          if ($is_prime[$p] == true) {
            // Mark all multiples of p starting from p*p
            var $multiple { value = $p * $p }
            while ($multiple <= $input.n) {
              each {
                var.update $is_prime { value = $is_prime|set:$multiple:false }
                var.update $multiple { value = $multiple + $p }
              }
            }
          }
        }
        var.update $p { value = $p + 1 }
      }
    }
    
    // Collect all primes into result array
    var $result { value = [] }
    var $num { value = 2 }
    while ($num <= $input.n) {
      each {
        conditional {
          if ($is_prime[$num] == true) {
            var.update $result { value = $result|push:$num }
          }
        }
        var.update $num { value = $num + 1 }
      }
    }
  }
  response = $result
}
