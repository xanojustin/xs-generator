// Helper function to find median of an array
// Sorts the array and returns the median value
function "find_median_sorted" {
  description = "Sorts array and returns the median value"

  input {
    int[] arr { description = "Array of integers to find median of" }
  }

  stack {
    var $n { value = $input.arr|count }

    // Handle single element case
    conditional {
      if ($n == 1) {
        var $sorted { value = $input.arr }
      }
      else {
        // Sort the array using bubble sort with array rebuilding
        var $sorted { value = $input.arr }
        var $i { value = 0 }

        while ($i < $n) {
          each {
            var $j { value = 0 }
            while ($j < ($n - $i - 1)) {
              each {
                // Check if we need to swap
                conditional {
                  if ($sorted[$j] > $sorted[$j + 1]) {
                    // Rebuild array with swapped elements
                    var $new_sorted { value = [] }
                    var $k { value = 0 }

                    // Copy elements before swap position
                    while ($k < $j) {
                      each {
                        var $new_sorted {
                          value = $new_sorted ~ [$sorted[$k]]
                        }
                        var.update $k { value = $k + 1 }
                      }
                    }

                    // Add swapped elements in reverse order
                    var $new_sorted {
                      value = $new_sorted ~ [$sorted[$j + 1]]
                    }
                    var $new_sorted {
                      value = $new_sorted ~ [$sorted[$j]]
                    }

                    // Update k to continue after swapped elements
                    var $k { value = $j + 2 }

                    // Copy remaining elements
                    while ($k < $n) {
                      each {
                        var $new_sorted {
                          value = $new_sorted ~ [$sorted[$k]]
                        }
                        var.update $k { value = $k + 1 }
                      }
                    }

                    var $sorted { value = $new_sorted }
                  }
                }
                var.update $j { value = $j + 1 }
              }
            }
            var.update $i { value = $i + 1 }
          }
        }
      }
    }

    // Calculate median based on whether count is odd or even
    conditional {
      if (($n % 2) == 1) {
        // Odd count: middle element
        var $mid_idx { value = ($n / 2)|floor }
        var $median { value = $sorted[$mid_idx] }
      }
      else {
        // Even count: average of two middle elements
        var $right_idx { value = $n / 2 }
        var $left_idx { value = $right_idx - 1 }
        var $median {
          value = ($sorted[$left_idx] + $sorted[$right_idx]) / 2
        }
      }
    }
  }

  response = $median
}
