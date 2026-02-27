// Replace Elements with Greatest Element on Right Side
// Given an array, replace every element with the greatest element among the elements to its right,
// and replace the last element with -1.
function "replace_greatest" {
  description = "Replaces each element with the greatest element to its right"

  input {
    int[] arr { description = "Array of integers to process" }
  }

  stack {
    var $n { value = $input.arr|count }
    var $result { value = [] }
    var $max_from_right { value = -1 }
    var $i { value = $n - 1 }

    // Work backwards from the end of the array
    while ($i >= 0) {
      each {
        // Store current element before we potentially update max
        var $current { value = $input.arr|get:$i }

        // Add max_from_right to result (working backwards, so we prepend)
        var $result {
          value = [$max_from_right]|merge:$result
        }

        // Update max_from_right to include current element for next iteration
        conditional {
          if ($current > $max_from_right) {
            var.update $max_from_right { value = $current }
          }
        }

        var.update $i { value = $i - 1 }
      }
    }
  }

  response = $result
}
