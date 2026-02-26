// Shortest Path in Binary Matrix - BFS traversal problem
// Finds the shortest path from top-left to bottom-right in a binary matrix
// where 0 represents clear path and 1 represents obstacle
function "shortest_path" {
  description = "Finds the shortest path length from top-left to bottom-right in a binary matrix"

  input {
    json grid { description = "2D array of 0s and 1s where 0 represents clear path and 1 represents obstacle" }
  }

  stack {
    // Handle empty grid
    var $n { value = $input.grid|count }
    conditional {
      if ($n == 0) {
        return { value = -1 }
      }
    }

    // Check if start or end is blocked
    conditional {
      if ($input.grid[0][0] == 1 || $input.grid[$n - 1][$n - 1] == 1) {
        return { value = -1 }
      }
    }

    // Special case: single cell
    conditional {
      if ($n == 1) {
        return { value = 1 }
      }
    }

    // BFS queue - each element is [row, col, distance]
    var $queue { value = [[0, 0, 1]] }

    // Create visited matrix
    var $visited { value = [] }
    var $r { value = 0 }
    while ($r < $n) {
      each {
        var $row { value = [] }
        var $c { value = 0 }
        while ($c < $n) {
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

    // Mark start as visited
    var.update $visited[0] { value = $visited[0]|set:0:true }

    // 8-directional movement: up, down, left, right, and 4 diagonals
    var $directions { value = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1],           [0, 1],
      [1, -1],  [1, 0],  [1, 1]
    ] }

    // BFS traversal
    while (($queue|count) > 0) {
      each {
        // Dequeue front element
        array.shift $queue as $current
        var $row { value = $current[0] }
        var $col { value = $current[1] }
        var $dist { value = $current[2] }

        // Explore all 8 directions
        var $d { value = 0 }
        while ($d < 8) {
          each {
            var $new_row { value = $row + $directions[$d][0] }
            var $new_col { value = $col + $directions[$d][1] }

            // Check if we reached the destination
            conditional {
              if ($new_row == ($n - 1) && $new_col == ($n - 1)) {
                return { value = $dist + 1 }
              }
            }

            // Check bounds
            conditional {
              if ($new_row < 0 || $new_row >= $n || $new_col < 0 || $new_col >= $n) {
                math.add $d { value = 1 }
                continue
              }
            }

            // Check if cell is clear and not visited
            conditional {
              if ($input.grid[$new_row][$new_col] == 0 && !$visited[$new_row][$new_col]) {
                // Mark as visited
                var.update $visited[$new_row] { value = $visited[$new_row]|set:$new_col:true }

                // Enqueue with incremented distance
                array.push $queue {
                  value = [$new_row, $new_col, $dist + 1]
                }
              }
            }

            math.add $d { value = 1 }
          }
        }
      }
    }

    // No path found
    return { value = -1 }
  }

  response = $response
}
