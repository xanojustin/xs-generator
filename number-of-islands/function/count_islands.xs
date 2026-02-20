// Number of Islands - Classic grid/graph traversal problem
// Counts the number of islands in a 2D grid where 1 represents land and 0 represents water
function "count_islands" {
  description = "Counts the number of islands in a 2D binary grid"

  input {
    json grid { description = "2D array of 0s and 1s where 1 represents land" }
  }

  stack {
    // Handle empty grid
    var $rows { value = $input.grid|count }
    conditional {
      if ($rows == 0) {
        return { value = 0 }
      }
    }

    var $cols { value = $input.grid[0]|count }
    conditional {
      if ($cols == 0) {
        return { value = 0 }
      }
    }

    // Create a visited matrix to track which cells have been explored
    var $visited { value = [] }
    var $r { value = 0 }
    while ($r < $rows) {
      each {
        var $row { value = [] }
        var $c { value = 0 }
        while ($c < $cols) {
          each {
            array.push $row {
              value = false
            }
            math.add $c { value = 1 }
          }
        }
        array.push $visited {
          value = $row
        }
        math.add $r { value = 1 }
      }
    }

    // Count islands using DFS
    var $island_count { value = 0 }

    var $i { value = 0 }
    while ($i < $rows) {
      each {
        var $j { value = 0 }
        while ($j < $cols) {
          each {
            // Check if current cell is land and not visited
            conditional {
              if ($input.grid[$i][$j] == 1 && !$visited[$i][$j]) {
                // Found a new island - perform DFS to mark all connected land
                var $stack { value = [[$i, $j]] }

                while (($stack|count) > 0) {
                  each {
                    // Pop from stack
                    array.pop $stack as $pos
                    var $row_pos { value = $pos[0] }
                    var $col_pos { value = $pos[1] }

                    // Check bounds and if already visited
                    conditional {
                      if ($row_pos < 0 || $row_pos >= $rows || $col_pos < 0 || $col_pos >= $cols) {
                        continue
                      }
                    }

                    conditional {
                      if ($visited[$row_pos][$col_pos] || $input.grid[$row_pos][$col_pos] == 0) {
                        continue
                      }
                    }

                    // Mark as visited
                    var.update $visited[$row_pos] { value = $visited[$row_pos]|set:$col_pos:true }

                    // Add all 4 neighbors to stack (up, down, left, right)
                    array.push $stack {
                      value = [$row_pos - 1, $col_pos]
                    }
                    array.push $stack {
                      value = [$row_pos + 1, $col_pos]
                    }
                    array.push $stack {
                      value = [$row_pos, $col_pos - 1]
                    }
                    array.push $stack {
                      value = [$row_pos, $col_pos + 1]
                    }
                  }
                }

                // Increment island count
                math.add $island_count { value = 1 }
              }
            }
            math.add $j { value = 1 }
          }
        }
        math.add $i { value = 1 }
      }
    }
  }

  response = $island_count
}
