// Minimum Path Sum - Dynamic Programming Exercise
// Find the minimum sum path from top-left to bottom-right in a grid
// Only allowed moves: right or down
function "minimum_path_sum" {
  description = "Finds the minimum path sum from top-left to bottom-right in a 2D grid"

  input {
    json grid { description = "2D array of non-negative integers representing the grid" }
  }

  stack {
    // Get dimensions
    var $rows { value = $input.grid|count }
    var $cols { value = 0 }

    // Handle empty grid edge case
    conditional {
      if ($rows == 0) {
        return { value = 0 }
      }
    }

    var $cols { value = $input.grid[0]|count }

    // Handle single cell edge case
    conditional {
      if ($rows == 1 && $cols == 1) {
        return { value = $input.grid[0][0] }
      }
    }

    // Create DP table - we'll modify in place using the grid copy
    var $dp { value = [] }

    // Initialize first row of DP table
    var $j { value = 0 }
    while ($j < $cols) {
      each {
        conditional {
          if ($j == 0) {
            // First cell - just copy the value
            array.push $dp {
              value = [$input.grid[0][0]]
            }
          }
          else {
            // Can only come from the left
            var $left_sum { value = $dp[0][$j - 1] + $input.grid[0][$j] }
            array.push $dp[0] {
              value = $left_sum
            }
          }
        }
        var.update $j { value = $j + 1 }
      }
    }

    // Fill in the rest of the DP table
    var $i { value = 1 }
    while ($i < $rows) {
      each {
        // Start a new row
        var $new_row { value = [] }

        // First column - can only come from above
        var $from_above { value = $dp[$i - 1][0] + $input.grid[$i][0] }
        array.push $new_row {
          value = $from_above
        }

        // Rest of the columns - min of from above or from left
        var $j { value = 1 }
        while ($j < $cols) {
          each {
            var $from_top { value = $dp[$i - 1][$j] }
            var $from_left { value = $new_row[$j - 1] }

            // Take the minimum path
            var $min_prev { value = $from_top }
            conditional {
              if ($from_left < $from_top) {
                var.update $min_prev { value = $from_left }
              }
            }

            var $cell_sum { value = $min_prev + $input.grid[$i][$j] }
            array.push $new_row {
              value = $cell_sum
            }

            var.update $j { value = $j + 1 }
          }
        }

        // Add the completed row to dp
        array.push $dp {
          value = $new_row
        }

        var.update $i { value = $i + 1 }
      }
    }
  }

  response = $dp[$rows - 1][$cols - 1]
}
