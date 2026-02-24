function "is_power_of_three" {
  description = "Check if a number is a power of three"
  input {
    int n
  }
  stack {
    // Handle edge cases: 0 and negative numbers are not powers of three
    conditional {
      if ($input.n <= 0) {
        return { value = false }
      }
    }

    // Handle the case where n = 1 (3^0 = 1)
    conditional {
      if ($input.n == 1) {
        return { value = true }
      }
    }

    // Keep dividing by 3 as long as divisible
    var $current { value = $input.n }
    var $is_power { value = true }

    while ($current > 1) {
      each {
        conditional {
          if (($current % 3) != 0) {
            var.update $is_power { value = false }
            break
          }
        }
        var.update $current { value = $current / 3 }
      }
    }
  }
  response = $is_power
}
