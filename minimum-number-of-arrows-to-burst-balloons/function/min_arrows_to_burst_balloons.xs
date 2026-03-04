function "min_arrows_to_burst_balloons" {
  description = "Find the minimum number of arrows needed to burst all balloons using a greedy approach"
  input {
    object[] points {
      description = "Array of balloons where each balloon has start and end properties"
      schema {
        int start
        int end
      }
    }
  }
  stack {
    // Handle edge case: empty input
    conditional {
      if (($input.points|count) == 0) {
        return { value = 0 }
      }
    }

    // Sort balloons by their end coordinate
    var $sorted_points {
      value = $input.points|sort:"end":"int":true
    }

    // Initialize arrow count and position
    var $arrow_count {
      value = 1
    }
    var $arrow_pos {
      value = $sorted_points|first|get:"end"
    }

    // Get the sorted array for iteration
    var $balloons {
      value = $sorted_points
    }

    // Iterate through remaining balloons (skip first)
    var $is_first {
      value = true
    }

    foreach ($balloons) {
      each as $balloon {
        // Skip the first balloon
        conditional {
          if ($is_first == true) {
            var.update $is_first { value = false }
            continue
          }
        }

        // If current balloon starts after the arrow position,
        // we need a new arrow
        conditional {
          if ($balloon.start > $arrow_pos) {
            var.update $arrow_count {
              value = $arrow_count + 1
            }
            var.update $arrow_pos {
              value = $balloon.end
            }
          }
        }
      }
    }
  }
  response = $arrow_count
}
