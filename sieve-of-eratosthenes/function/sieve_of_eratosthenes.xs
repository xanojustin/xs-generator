function "sieve_of_eratosthenes" {
  description = "Find all prime numbers up to a given limit using the Sieve of Eratosthenes algorithm"
  input {
    int limit filters=min:2 { description = "Upper bound (inclusive) for finding primes" }
  }
  stack {
    // Initialize object where key represents the number
    // Value true = potentially prime, false = not prime
    var $is_prime {
      value = {}
    }
    
    // Initialize all entries as true (potential primes)
    var $idx {
      value = 0
    }
    while ($idx <= $input.limit) {
      each {
        var.update $is_prime {
          value = $is_prime|set:($idx|to_text):true
        }
        var.update $idx {
          value = $idx + 1
        }
      }
    }
    
    // 0 and 1 are not prime
    var.update $is_prime {
      value = $is_prime|set:"0":false
    }
    var.update $is_prime {
      value = $is_prime|set:"1":false
    }
    
    // Calculate square root of limit for optimization
    var $sqrt_limit {
      value = ($input.limit|to_decimal)|sqrt|to_int
    }
    
    // Main sieve algorithm
    // For each number i from 2 to sqrt(limit)
    var $i {
      value = 2
    }
    while ($i <= $sqrt_limit) {
      each {
        // If i is still marked as prime
        conditional {
          if ($is_prime|get:($i|to_text)) {
            // Mark all multiples of i as not prime
            // Start from i*i (all smaller multiples already marked)
            var $multiple {
              value = $i * $i
            }
            while ($multiple <= $input.limit) {
              each {
                var.update $is_prime {
                  value = $is_prime|set:($multiple|to_text):false
                }
                var.update $multiple {
                  value = $multiple + $i
                }
              }
            }
          }
        }
        var.update $i {
          value = $i + 1
        }
      }
    }
    
    // Collect all prime numbers
    var $primes {
      value = []
    }
    var $num {
      value = 2
    }
    while ($num <= $input.limit) {
      each {
        conditional {
          if ($is_prime|get:($num|to_text)) {
            var.update $primes {
              value = $primes|append:$num
            }
          }
        }
        var.update $num {
          value = $num + 1
        }
      }
    }
  }
  response = $primes
}