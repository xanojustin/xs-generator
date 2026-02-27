// Heaters - Find minimum radius to warm all houses
// Given house positions and heater positions, find the minimum radius
// so that every house is within at least one heater's range
function "heaters" {
  description = "Finds minimum heater radius to cover all houses"

  input {
    int[] houses { description = "Array of house positions on a horizontal line" }
    int[] heaters { description = "Array of heater positions on a horizontal line" }
  }

  stack {
    // Sort both arrays to enable binary search
    var $sorted_houses {
      value = $input.houses|sort
    }
    var $sorted_heaters {
      value = $input.heaters|sort
    }

    var $min_radius { value = 0 }
    var $house_idx { value = 0 }

    // Iterate through each house to find its closest heater
    while ($house_idx < $sorted_houses|count) {
      each {
        var $house_pos {
          value = $sorted_houses[$house_idx]
        }

        // Binary search to find the closest heater
        var $left { value = 0 }
        var $right {
          value = ($sorted_heaters|count) - 1
        }
        // Initialize with max int value
        var $closest_dist {
          value = 2147483647
        }

        while ($left <= $right) {
          each {
            var $mid {
              value = ($left + $right) / 2
            }
            var $heater_pos {
              value = $sorted_heaters[$mid]
            }
            var $dist {
              value = $house_pos - $heater_pos
            }

            conditional {
              if ($dist < 0) {
                var $dist {
                  value = 0 - $dist
                }
              }
            }

            conditional {
              if ($dist < $closest_dist) {
                var.update $closest_dist { value = $dist }
              }
            }

            conditional {
              if ($house_pos < $heater_pos) {
                var.update $right { value = $mid - 1 }
              }
              elseif ($house_pos > $heater_pos) {
                var.update $left { value = $mid + 1 }
              }
              else {
                // House is exactly at heater position, distance is 0
                var.update $closest_dist { value = 0 }
                var.update $left { value = 1 }
                var.update $right { value = 0 }
              }
            }
          }
        }

        // Update minimum radius if this house needs a larger radius
        conditional {
          if ($closest_dist > $min_radius) {
            var.update $min_radius { value = $closest_dist }
          }
        }

        var.update $house_idx { value = $house_idx + 1 }
      }
    }
  }

  response = $min_radius
}
