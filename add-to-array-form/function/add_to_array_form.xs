// Add to Array-Form of Integer
// The array-form of an integer num is an array representing its digits in left to right order.
// Given an array-form integer num and an integer k, return the array-form of the sum.
function "add_to_array_form" {
  description = "Adds an integer k to an array-form integer"

  input {
    int[] num { description = "Array representing the digits of the number" }
    int k { description = "Integer to add" }
  }

  stack {
    var $result { value = [] }
    var $i { value = ($input.num|count) - 1 }
    var $carry { value = $input.k }

    // Process from right to left (least significant digit)
    while ($i >= 0 || $carry > 0) {
      each {
        conditional {
          if ($i >= 0) {
            // Add current digit to carry
            var.update $carry { value = $carry + $input.num[$i] }
          }
        }

        // Append the last digit of carry to result
        var $digit { value = $carry % 10 }
        var $result { value = [$digit]|merge:$result }

        // Update carry for next iteration
        var.update $carry { value = ($carry / 10)|floor }
        var.update $i { value = $i - 1 }
      }
    }
  }

  response = $result
}
