// Minimum Falling Path Sum - Dynamic Programming Exercise
// Given a square matrix, find the minimum sum of a falling path from top to bottom.
// A falling path starts at any element in the first row and moves to an adjacent
// element in the next row (directly below, diagonally left, or diagonally right).
function "minimum_falling_path_sum" {
  description = "Finds the minimum sum of any falling path through the matrix"

  input {
    json matrix { description = "n x n square matrix of integers" }
  }

  stack {
    // Get the size of the matrix
    var $n { value = $input.matrix|count }

    // Edge case: empty matrix
    conditional {
      if ($n == 0) {
        return { value = 0 }
      }
    }

    // Edge case: 1x1 matrix
    conditional {
      if ($n == 1) {
        return { value = $input.matrix[0][0] }
      }
    }

    // Create a DP table initialized with a copy of the first row
    var $dp { value = [] }
    var $i { value = 0 }
    while ($i < $n) {
      each {
        var $val { value = $input.matrix[0][$i] }
        var $dp { value = $dp|merge:[$val] }
        var.update $i { value = $i + 1 }
      }
    }

    // Process each row starting from the second row
    var $row { value = 1 }
    while ($row < $n) {
      each {
        // Create a new row for updated DP values
        var $new_dp { value = [] }

        var $col { value = 0 }
        while ($col < $n) {
          each {
            // Current cell value
            var $current { value = $input.matrix[$row][$col] }

            // Start with the value from directly above
            var $min_path { value = $dp[$col] }

            // Check diagonal left (if valid)
            conditional {
              if ($col > 0) {
                conditional {
                  if ($dp[$col - 1] < $min_path) {
                    var.update $min_path { value = $dp[$col - 1] }
                  }
                }
              }
            }

            // Check diagonal right (if valid)
            conditional {
              if ($col < $n - 1) {
                conditional {
                  if ($dp[$col + 1] < $min_path) {
                    var.update $min_path { value = $dp[$col + 1] }
                  }
                }
              }
            }

            // Add current cell to the minimum path sum
            var $cell_sum { value = $current + $min_path }
            var $new_dp { value = $new_dp|merge:[$cell_sum] }

            var.update $col { value = $col + 1 }
          }
        }

        // Update dp to be the new row
        var $dp { value = $new_dp }
        var.update $row { value = $row + 1 }
      }
    }

    // Find the minimum value in the last row of dp
    var $min_sum { value = $dp[0] }
    var $j { value = 1 }
    while ($j < $n) {
      each {
        conditional {
          if ($dp[$j] < $min_sum) {
            var.update $min_sum { value = $dp[$j] }
          }
        }
        var.update $j { value = $j + 1 }
      }
    }

    return { value = $min_sum }
  }

  response = $response
}
