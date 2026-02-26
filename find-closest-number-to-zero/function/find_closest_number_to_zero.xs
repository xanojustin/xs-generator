function "find_closest_number_to_zero" {
  description = "Find the number closest to zero. If tie, return the positive number."
  input {
    int[] nums
  }
  stack {
    // Handle empty array edge case
    precondition (($input.nums|count) > 0) {
      error_type = "inputerror"
      error = "Input array cannot be empty"
    }

    // Start with first element as closest
    var $closest {
      value = $input.nums|first
    }

    // Iterate through remaining elements
    foreach ($input.nums) {
      each as $num {
        // Calculate absolute value of current number
        var $current_abs {
          value = $num
        }
        conditional {
          if ($num < 0) {
            var.update $current_abs { value = 0 - $num }
          }
        }

        // Calculate absolute value of closest number
        var $closest_abs {
          value = $closest
        }
        conditional {
          if ($closest < 0) {
            var.update $closest_abs { value = 0 - $closest }
          }
        }

        conditional {
          // If current number is closer to zero
          if ($current_abs < $closest_abs) {
            var.update $closest { value = $num }
          }
          // If equal distance, prefer positive number
          elseif ($current_abs == $closest_abs) {
            conditional {
              if ($num > $closest) {
                var.update $closest { value = $num }
              }
            }
          }
        }
      }
    }
  }
  response = $closest
}
