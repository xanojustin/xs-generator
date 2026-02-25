// Dungeon Game - Dynamic Programming Exercise
// Calculate minimum initial health for knight to rescue princess
// Knight starts top-left, must reach bottom-right
// Each cell: positive = health gain, negative = health loss (damage)
// Knight needs at least 1 HP at all times
function "dungeon_game" {
  description = "Calculate minimum initial health needed to rescue the princess"

  input {
    json dungeon { description = "2D grid where values represent health changes" }
  }

  stack {
    // Get dimensions
    var $rows { value = $input.dungeon|count }
    var $cols { value = 0 }

    // Handle empty dungeon edge case
    conditional {
      if ($rows == 0) {
        return { value = 1 }
      }
    }

    var $cols { value = $input.dungeon[0]|count }

    // Handle empty columns edge case
    conditional {
      if ($cols == 0) {
        return { value = 1 }
      }
    }

    // dp[i][j] = minimum health needed to reach princess from cell (i,j)
    var $dp { value = [] }

    // Fill dp table from bottom-right to top-left
    var $i { value = $rows - 1 }
    while ($i >= 0) {
      each {
        // Start a new row
        var $new_row { value = [] }

        var $j { value = $cols - 1 }
        while ($j >= 0) {
          each {
            conditional {
              // Princess cell (bottom-right)
              if ($i == $rows - 1 && $j == $cols - 1) {
                // Need at least 1 HP after reaching princess
                // So if dungeon has -5, we need 6 health before entering
                var $needed { value = 1 - $input.dungeon[$i][$j] }
                conditional {
                  if ($needed < 1) {
                    var $needed { value = 1 }
                  }
                }
                array.push $new_row {
                  value = $needed
                }
              }
              // Last row - can only go right
              elseif ($i == $rows - 1) {
                // Get the right cell value (which is already in new_row since we're going right to left)
                // new_row is built right-to-left, so we need to prepend
                var $right_cell { value = $new_row[0] }
                var $needed { value = $right_cell - $input.dungeon[$i][$j] }
                conditional {
                  if ($needed < 1) {
                    var $needed { value = 1 }
                  }
                }
                // Prepend to new_row
                var $new_row { value = [$needed]|merge:$new_row }
              }
              // Last column - can only go down
              elseif ($j == $cols - 1) {
                var $down_cell { value = $dp[0][0] }
                var $needed { value = $down_cell - $input.dungeon[$i][$j] }
                conditional {
                  if ($needed < 1) {
                    var $needed { value = 1 }
                  }
                }
                array.push $new_row {
                  value = $needed
                }
              }
              // Other cells - choose path requiring less health
              else {
                // From right (already in new_row)
                var $right_cell { value = $new_row[0] }
                // From down (in dp[0] since dp is built bottom-up)
                var $down_cell { value = $dp[0][$j] }

                var $min_needed { value = $right_cell }
                conditional {
                  if ($down_cell < $right_cell) {
                    var $min_needed { value = $down_cell }
                  }
                }

                var $needed { value = $min_needed - $input.dungeon[$i][$j] }
                conditional {
                  if ($needed < 1) {
                    var $needed { value = 1 }
                  }
                }
                // Prepend to new_row
                var $new_row { value = [$needed]|merge:$new_row }
              }
            }
            var.update $j { value = $j - 1 }
          }
        }

        // Prepend the new row to dp (since we're building bottom-up)
        var $dp { value = [$new_row]|merge:$dp }

        var.update $i { value = $i - 1 }
      }
    }

    var $result { value = $dp[0][0] }
  }

  response = $result
}
