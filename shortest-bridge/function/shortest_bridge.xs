// Shortest Bridge - BFS/Graph Exercise
// Given an n x n binary matrix, find the shortest bridge (min 0s to flip) to connect two islands
function "shortest_bridge" {
  description = "Finds the shortest bridge to connect two islands in a binary matrix"
  
  input {
    json grid { description = "An n x n binary matrix where 1=land, 0=water" }
  }
  
  stack {
    // Get grid dimensions
    var $n { value = $input.grid|count }
    
    // Handle edge cases
    conditional {
      if ($n == 0) {
        return { value = 0 }
      }
    }
    
    // Visited matrix to track which cells belong to first island
    var $visited { value = [] }
    var $i { value = 0 }
    while ($i < $n) {
      each {
        var $row { value = [] }
        var $j { value = 0 }
        while ($j < $n) {
          each {
            var.update $row { value = $row ~ [false] }
            var.update $j { value = $j + 1 }
          }
        }
        var.update $visited { value = $visited ~ [$row] }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Find first island using DFS and mark visited
    var $found_island { value = false }
    var $start_row { value = 0 }
    
    while ($start_row < $n && !$found_island) {
      each {
        var $start_col { value = 0 }
        while ($start_col < $n && !$found_island) {
          each {
            conditional {
              if ($input.grid[$start_row][$start_col] == 1) {
                // Found first land cell, DFS to mark entire island
                var.update $found_island { value = true }
                
                // DFS stack (iterative)
                var $stack { value = [[$start_row, $start_col]] }
                
                while (($stack|count) > 0) {
                  each {
                    var $cell { value = $stack|last }
                    var.update $stack { value = $stack|slice:0:(($stack|count) - 1) }
                    
                    var $r { value = $cell[0] }
                    var $c { value = $cell[1] }
                    
                    // Check bounds and if already visited or water
                    conditional {
                      if ($r < 0 || $r >= $n || $c < 0 || $c >= $n) {
                        // Out of bounds, skip
                      }
                      elseif ($visited[$r][$c]) {
                        // Already visited, skip
                      }
                      elseif ($input.grid[$r][$c] == 0) {
                        // Water, skip
                      }
                      else {
                        // Mark as visited (part of first island)
                        var.update $visited[$r] { value = $visited[$r]|slice:0:$c ~ [true] ~ $visited[$r]|slice:($c + 1) }
                        
                        // Add neighbors to stack
                        var.update $stack { value = $stack ~ [[$r - 1, $c]] }
                        var.update $stack { value = $stack ~ [[$r + 1, $c]] }
                        var.update $stack { value = $stack ~ [[$r, $c - 1]] }
                        var.update $stack { value = $stack ~ [[$r, $c + 1]] }
                      }
                    }
                  }
                }
              }
            }
            var.update $start_col { value = $start_col + 1 }
          }
        }
        var.update $start_row { value = $start_row + 1 }
      }
    }
    
    // BFS from first island to find shortest bridge to second island
    // Start with all cells of first island in the queue
    var $queue { value = [] }
    var $row_idx { value = 0 }
    while ($row_idx < $n) {
      each {
        var $col_idx { value = 0 }
        while ($col_idx < $n) {
          each {
            conditional {
              if ($visited[$row_idx][$col_idx]) {
                var.update $queue { value = $queue ~ [[$row_idx, $col_idx, 0]] }
              }
            }
            var.update $col_idx { value = $col_idx + 1 }
          }
        }
        var.update $row_idx { value = $row_idx + 1 }
      }
    }
    
    // BFS
    var $bridge_length { value = 0 }
    
    while (($queue|count) > 0) {
      each {
        var $current { value = $queue[0] }
        var.update $queue { value = $queue|slice:1 }
        
        var $cr { value = $current[0] }
        var $cc { value = $current[1] }
        var $dist { value = $current[2] }
        
        // Check all 4 directions
        var $directions { value = [[-1, 0], [1, 0], [0, -1], [0, 1]] }
        
        foreach ($directions) {
          each as $dir {
            var $nr { value = $cr + $dir[0] }
            var $nc { value = $cc + $dir[1] }
            
            // Check bounds
            conditional {
              if ($nr >= 0 && $nr < $n && $nc >= 0 && $nc < $n) {
                conditional {
                  if (!$visited[$nr][$nc]) {
                    // Not visited yet
                    conditional {
                      if ($input.grid[$nr][$nc] == 1) {
                        // Found second island!
                        return { value = $dist }
                      }
                      else {
                        // Water cell, add to queue with distance+1
                        var.update $visited[$nr] { value = $visited[$nr]|slice:0:$nc ~ [true] ~ $visited[$nr]|slice:($nc + 1) }
                        var.update $queue { value = $queue ~ [[$nr, $nc, $dist + 1]] }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    
    // If we get here, no bridge found (shouldn't happen with valid input)
    return { value = -1 }
  }
  
  response = $response
}
