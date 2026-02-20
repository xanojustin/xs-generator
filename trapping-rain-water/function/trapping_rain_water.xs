function "trapping_rain_water" {
  description = "Calculate trapped rain water using two-pointer approach"
  input {
    int[] heights
  }
  stack {
    // Handle edge cases
    conditional {
      if (($input.heights|count) < 3) {
        return { value = 0 }
      }
    }

    // Initialize pointers and max values
    var $left {
      value = 0
    }
    var $right {
      value = ($input.heights|count) - 1
    }
    var $left_max {
      value = 0
    }
    var $right_max {
      value = 0
    }
    var $water {
      value = 0
    }

    // Two-pointer traversal
    while ($left < $right) {
      each {
        conditional {
          // Get current heights at pointers
          if ($input.heights[$left] < $input.heights[$right]) {
            // Process left side
            conditional {
              if ($input.heights[$left] >= $left_max) {
                // Update left max
                var.update $left_max {
                  value = $input.heights[$left]
                }
              }
              else {
                // Add trapped water
                math.add $water {
                  value = $left_max - $input.heights[$left]
                }
              }
            }
            // Move left pointer
            math.add $left {
              value = 1
            }
          }
          else {
            // Process right side
            conditional {
              if ($input.heights[$right] >= $right_max) {
                // Update right max
                var.update $right_max {
                  value = $input.heights[$right]
                }
              }
              else {
                // Add trapped water
                math.add $water {
                  value = $right_max - $input.heights[$right]
                }
              }
            }
            // Move right pointer
            math.sub $right {
              value = 1
            }
          }
        }
      }
    }
  }
  response = $water
}
