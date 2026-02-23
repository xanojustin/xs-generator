function "count_primes" {
  description = "Count the number of prime numbers less than n using Sieve of Eratosthenes"
  input {
    int n { description = "Upper bound (exclusive)" }
  }
  stack {
    // Handle edge cases: less than 2 has no primes
    conditional {
      if ($input.n <= 2) {
        return { value = 0 }
      }
    }

    // Initialize boolean array where is_prime[i] = true means i is potentially prime
    var $is_prime {
      value = []
    }

    // Fill array with true values (all numbers start as potentially prime)
    for ($input.n) {
      each as $i {
        var.update $is_prime {
          value = $is_prime|push:true
        }
      }
    }

    // 0 and 1 are not prime
    var.update $is_prime {
      value = $is_prime|set:0:false
    }
    var.update $is_prime {
      value = $is_prime|set:1:false
    }

    // Sieve of Eratosthenes
    // For each i from 2 to sqrt(n), if i is prime, mark its multiples as not prime
    var $i { value = 2 }
    var $limit {
      value = ($input.n|to_decimal|sqrt|to_int) + 1
    }

    while ($i < $limit) {
      each {
        conditional {
          if ($is_prime|get:$i:true) {
            // Mark all multiples of i as not prime, starting from i*i
            var $j { value = $i * $i }
            while ($j < $input.n) {
              each {
                var.update $is_prime {
                  value = $is_prime|set:$j:false
                }
                var.update $j { value = $j + $i }
              }
            }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }

    // Count primes
    var $count { value = 0 }
    var $idx { value = 0 }
    foreach ($is_prime) {
      each as $prime_flag {
        conditional {
          if ($prime_flag) {
            var.update $count { value = $count + 1 }
          }
        }
        var.update $idx { value = $idx + 1 }
      }
    }
  }
  response = $count
}
