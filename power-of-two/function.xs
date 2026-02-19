function "is-power-of-two" {
  description = "Check if a number is a power of two"
  input {
    int n {
      description = "The number to check (can be any integer, positive, negative, or zero)"
    }
  }
  stack {
    // Powers of two must be positive (1, 2, 4, 8, 16, ...)
    // Zero and negative numbers are not powers of two
    conditional {
      if ($input.n <= 0) {
        var $result { value = false }
      }
      else {
        // Check if n is a power of two using repeated division
        // A power of two in binary has exactly one bit set (e.g., 8 = 1000)
        // Repeatedly divide by 2 - if we ever get an odd number > 1, it's not a power of two
        var $current { value = $input.n }
        var $is_power { value = true }

        while ($current > 1 && $is_power) {
          each {
            conditional {
              // If current is odd and greater than 1, it's not a power of two
              if ($current % 2 != 0) {
                var.update $is_power { value = false }
              }
              else {
                var.update $current { value = $current / 2 }
              }
            }
          }
        }

        var $result { value = $is_power }
      }
    }
  }
  response = $result
}
