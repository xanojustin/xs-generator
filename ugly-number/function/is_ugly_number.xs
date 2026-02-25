function "is_ugly_number" {
  description = "Check if a number is an ugly number (prime factors only 2, 3, 5)"
  input {
    int n
  }
  stack {
    // Ugly numbers must be positive
    conditional {
      if ($input.n <= 0) {
        return { value = false }
      }
    }

    // 1 is considered an ugly number (no prime factors)
    conditional {
      if ($input.n == 1) {
        return { value = true }
      }
    }

    var $num { value = $input.n }

    // Divide out all factors of 2
    while (($num % 2) == 0) {
      each {
        var.update $num { value = $num / 2 }
      }
    }

    // Divide out all factors of 3
    while (($num % 3) == 0) {
      each {
        var.update $num { value = $num / 3 }
      }
    }

    // Divide out all factors of 5
    while (($num % 5) == 0) {
      each {
        var.update $num { value = $num / 5 }
      }
    }

    // If we're left with 1, only 2, 3, 5 were factors
    conditional {
      if ($num == 1) {
        return { value = true }
      }
      else {
        return { value = false }
      }
    }
  }
  response = true
}
