// Valid Mountain Array - Check if an array forms a valid mountain
// A valid mountain: strictly increases to a peak, then strictly decreases
// Requirements: at least 3 elements, peak cannot be first or last element
function "valid-mountain-array" {
  description = "Determines if an array is a valid mountain array"

  input {
    int[] arr { description = "Array of integers to check" }
  }

  stack {
    // Check if array has less than 3 elements
    conditional {
      if (($input.arr|count) < 3) {
        return { value = false }
      }
    }

    var $n { value = ($input.arr|count) }
    var $i { value = 0 }

    // Walk up: find the peak (strictly increasing)
    while ($i + 1 < $n && $input.arr[$i] < $input.arr[$i + 1]) {
      each {
        var.update $i { value = $i + 1 }
      }
    }

    // Peak cannot be first or last element
    conditional {
      if ($i == 0 || $i == $n - 1) {
        return { value = false }
      }
    }

    // Walk down: strictly decreasing from peak
    while ($i + 1 < $n && $input.arr[$i] > $input.arr[$i + 1]) {
      each {
        var.update $i { value = $i + 1 }
      }
    }

    // Valid mountain if we reached the end
    return { value = $i == $n - 1 }
  }

  response = $output
}
