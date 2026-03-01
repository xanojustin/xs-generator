function "tribonacci" {
  description = "Calculate the n-th Tribonacci number"

  input {
    int n { description = "The position in the Tribonacci sequence (0-indexed)" }
  }

  stack {
    // Handle edge cases for n = 0, 1, 2
    conditional {
      if ($input.n == 0) {
        return { value = 0 }
      }
      elseif ($input.n == 1) {
        return { value = 1 }
      }
      elseif ($input.n == 2) {
        return { value = 1 }
      }
    }

    // Iterative approach for efficiency
    // T(n) = T(n-1) + T(n-2) + T(n-3)
    // $first = T(n-3), $second = T(n-2), $third = T(n-1)
    var $first { value = 0 }
    var $second { value = 1 }
    var $third { value = 1 }
    var $i { value = 3 }

    while ($i <= $input.n) {
      each {
        var $next { value = $first + $second + $third }
        var.update $first { value = $second }
        var.update $second { value = $third }
        var.update $third { value = $next }
        var.update $i { value = $i + 1 }
      }
    }
  }

  response = $third
}
