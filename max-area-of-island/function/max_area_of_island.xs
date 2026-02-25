// Max Area of Island - Find the maximum area of an island in a 2D grid
// An island is a group of 1s (land) connected horizontally or vertically
function "max_area_of_island" {
  description = "Finds the maximum area of an island in a 2D binary grid"

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

    // Track the maximum island area found
    var $max_area { value = 0 }

    // Iterate through each cell in the grid
    var $i { value = 0 }
    while ($i < $rows) {
      each {
        var $j { value = 0 }
        while ($j < $cols) {
          each {
            // Check if current cell is land and not visited
            conditional {
              if ($input.grid[$i][$j] == 1 && !$visited[$i][$j]) {
                // Found a new island - perform DFS to calculate its area
                var $stack { value = [[$i, $j]] }
                var $current_area { value = 0 }

                while (($stack|count) > 0) {
                  each {
                    // Pop from stack
                    array.pop $stack as $pos
                    var $row_pos { value = $pos[0] }
                    var $col_pos { value = $pos[1] }

                    // Check bounds
                    conditional {
                      if ($row_pos < 0 || $row_pos >= $rows || $col_pos < 0 || $col_pos >= $cols) {
                        continue
                      }
                    }

                    // Skip if already visited or is water
                    conditional {
                      if ($visited[$row_pos][$col_pos] || $input.grid[$row_pos][$col_pos] == 0) {
                        continue
                      }
                    }

                    // Mark as visited and increment area
                    var.update $visited[$row_pos] { value = $visited[$row_pos]|set:$col_pos:true }
                    math.add $current_area { value = 1 }

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

                // Update max area if current island is larger
                conditional {
                  if ($current_area > $max_area) {
                    var.update $max_area { value = $current_area }
                  }
                }
              }
            }
            math.add $j { value = 1 }
          }
        }
        math.add $i { value = 1 }
      }
    }
  }

  response = $max_area
}
