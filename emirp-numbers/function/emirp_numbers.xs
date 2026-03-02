function "emirp_numbers" {
  description = "Check if a number is an emirp number (prime that becomes a different prime when reversed)"
  input {
    int n filters=min:0
  }
  stack {
    // Handle edge cases - numbers less than 2 are not prime
    conditional {
      if ($input.n < 2) {
        return { value = false }
      }
    }

    // Check if original number is prime
    var $is_original_prime { value = true }
    var $i { value = 2 }
    
    while ($i * $i <= $input.n) {
      each {
        conditional {
          if ($input.n % $i == 0) {
            var $is_original_prime { value = false }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }

    conditional {
      if (!$is_original_prime) {
        return { value = false }
      }
    }

    // Reverse the digits
    var $original { value = $input.n }
    var $reversed { value = 0 }
    
    while ($original > 0) {
      each {
        var $digit { value = $original % 10 }
        var.update $reversed { value = ($reversed * 10) + $digit }
        var.update $original { value = ($original / 10)|floor }
      }
    }

    // Emirp must be different from original (no palindromes)
    conditional {
      if ($reversed == $input.n) {
        return { value = false }
      }
    }

    // Check if reversed number is prime
    var $is_reversed_prime { value = true }
    var $j { value = 2 }
    
    while ($j * $j <= $reversed) {
      each {
        conditional {
          if ($reversed % $j == 0) {
            var $is_reversed_prime { value = false }
          }
        }
        var.update $j { value = $j + 1 }
      }
    }
  }
  response = $is_reversed_prime
}
