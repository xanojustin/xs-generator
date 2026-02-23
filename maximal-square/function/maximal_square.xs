// Maximal Square - Find the largest square containing only 1s in a binary matrix
function "maximal_square" {
  description = "Given a binary matrix filled with 0s and 1s, find the largest square containing only 1s and return its area."
  input {
    json matrix
  }
  stack {
    // Handle empty matrix
    conditional {
      if (($input.matrix|count) == 0) {
        return { value = 0 }
      }
    }

    var $rows { value = $input.matrix|count }
    var $cols { value = ($input.matrix|first)|count }

    // Handle empty rows
    conditional {
      if ($cols == 0) {
        return { value = 0 }
      }
    }

    // Initialize DP table and max side length
    var $max_side { value = 0 }
    var $dp { value = [] }

    // Build DP table where dp[i][j] = side length of largest square ending at (i,j)
    for ($rows) {
      each as $i {
        var $dp_row { value = [] }
        for ($cols) {
          each as $j {
            var $cell_value {
              value = $input.matrix[$i][$j]
            }

            conditional {
              // First row or first column - can only form 1x1 squares
              if ($i == 0 || $j == 0) {
                var $dp_val { value = $cell_value }
                var.update $dp_row { value = $dp_row|append:$dp_val }
                conditional {
                  if ($dp_val > $max_side) {
                    var.update $max_side { value = $dp_val }
                  }
                }
              }
              // Current cell is 0 - can't form a square ending here
              elseif ($cell_value == 0) {
                var.update $dp_row { value = $dp_row|append:0 }
              }
              // Current cell is 1 - check neighbors for square size
              else {
                var $min_neighbor {
                  value = $dp[$i - 1][$j]
                }
                conditional {
                  if (($dp[$i - 1][$j - 1]) < $min_neighbor) {
                    var.update $min_neighbor { value = $dp[$i - 1][$j - 1] }
                  }
                }
                conditional {
                  if (($dp_row[$j - 1]) < $min_neighbor) {
                    var.update $min_neighbor { value = $dp_row[$j - 1] }
                  }
                }
                var $new_val { value = $min_neighbor + 1 }
                var.update $dp_row { value = $dp_row|append:$new_val }
                conditional {
                  if ($new_val > $max_side) {
                    var.update $max_side { value = $new_val }
                  }
                }
              }
            }
          }
        }
        var.update $dp { value = $dp|append:$dp_row }
      }
    }

    // Return the area (side length squared)
    var $result { value = $max_side * $max_side }
  }
  response = $result
}
