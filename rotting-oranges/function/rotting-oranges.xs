// Rotting Oranges - BFS grid traversal problem
// Given a grid with fresh (1), rotten (2), and empty (0) cells,
// return minimum minutes until all fresh oranges become rotten, or -1 if impossible
function "rotting-oranges" {
  description = "Calculates minimum time for all oranges to rot using BFS"
  
  input {
    json grid { description = "2D grid: 0=empty, 1=fresh orange, 2=rotten orange" }
  }
  
  stack {
    // Get grid dimensions
    var $rows { value = $input.grid|count }
    
    // Handle empty grid
    conditional {
      if ($rows == 0) {
        return { value = 0 }
      }
    }
    
    var $cols { value = ($input.grid|first)|count }
    
    // Queue for BFS - each element is {row, col, minutes}
    var $queue { value = [] }
    var $fresh_count { value = 0 }
    
    // Find all initially rotten oranges and count fresh ones
    var $r { value = 0 }
    while ($r < $rows) {
      each {
        var $c { value = 0 }
        while ($c < $cols) {
          each {
            var $cell { value = $input.grid[$r][$c] }
            conditional {
              if ($cell == 2) {
                // Add rotten orange to queue with 0 minutes
                var $item { value = { "row": $r, "col": $c, "minutes": 0 } }
                var $queue { value = $queue|merge:[$item] }
              }
              elseif ($cell == 1) {
                var $fresh_count { value = $fresh_count + 1 }
              }
            }
            var.update $c { value = $c + 1 }
          }
        }
        var.update $r { value = $r + 1 }
      }
    }
    
    // If no fresh oranges, return 0
    conditional {
      if ($fresh_count == 0) {
        return { value = 0 }
      }
    }
    
    // Directions: up, down, left, right
    var $directions { 
      value = [
        { "dr": -1, "dc": 0 },
        { "dr": 1, "dc": 0 },
        { "dr": 0, "dc": -1 },
        { "dr": 0, "dc": 1 }
      ]
    }
    var $minutes_elapsed { value = 0 }
    var $queue_index { value = 0 }
    
    // Create mutable grid copy to track state
    var $grid_state { value = $input.grid }
    
    // BFS - process queue using index
    while ($queue_index < ($queue|count)) {
      each {
        var $current { value = $queue[$queue_index] }
        var $current_row { value = $current["row"] }
        var $current_col { value = $current["col"] }
        var $current_minutes { value = $current["minutes"] }
        
        // Update elapsed time
        var $minutes_elapsed { value = $current_minutes }
        
        // Process all 4 directions
        var $d { value = 0 }
        while ($d < 4) {
          each {
            var $dir { value = $directions[$d] }
            var $new_row { value = $current_row + $dir["dr"] }
            var $new_col { value = $current_col + $dir["dc"] }
            
            // Check bounds
            conditional {
              if (($new_row >= 0) && ($new_row < $rows) && ($new_col >= 0) && ($new_col < $cols)) {
                var $new_cell { value = $grid_state[$new_row][$new_col] }
                
                // If fresh orange, rot it
                conditional {
                  if ($new_cell == 1) {
                    var $fresh_count { value = $fresh_count - 1 }
                    var $new_minutes { value = $current_minutes + 1 }
                    
                    // Add to queue
                    var $new_item { 
                      value = { "row": $new_row, "col": $new_col, "minutes": $new_minutes }
                    }
                    var $queue { value = $queue|merge:[$new_item] }
                    
                    // Mark as rotten in grid_state by reconstructing the row
                    var $old_row { value = $grid_state[$new_row] }
                    var $new_row_data { value = [] }
                    
                    var $i { value = 0 }
                    while ($i < $cols) {
                      each {
                        conditional {
                          if ($i == $new_col) {
                            var $new_row_data { value = $new_row_data|merge:[2] }
                          }
                          else {
                            var $val { value = $old_row[$i] }
                            var $new_row_data { value = $new_row_data|merge:[$val] }
                          }
                        }
                        var.update $i { value = $i + 1 }
                      }
                    }
                    
                    // Update grid_state with new row
                    var $new_state { value = [] }
                    var $row_idx { value = 0 }
                    while ($row_idx < $rows) {
                      each {
                        conditional {
                          if ($row_idx == $new_row) {
                            var $new_state { value = $new_state|merge:[$new_row_data] }
                          }
                          else {
                            var $new_state { value = $new_state|merge:[$grid_state[$row_idx]] }
                          }
                        }
                        var.update $row_idx { value = $row_idx + 1 }
                      }
                    }
                    var $grid_state { value = $new_state }
                  }
                }
              }
            }
            
            var.update $d { value = $d + 1 }
          }
        }
        
        var.update $queue_index { value = $queue_index + 1 }
      }
    }
    
    // If fresh oranges remain, return -1
    conditional {
      if ($fresh_count > 0) {
        return { value = -1 }
      }
      else {
        return { value = $minutes_elapsed }
      }
    }
  }
  
  response = $output
}
