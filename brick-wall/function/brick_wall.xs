// Brick Wall - Hash Map Exercise
// Given a wall made of bricks of different widths, find the vertical line 
// that crosses the minimum number of bricks.
// A line crossing the edge between two bricks does NOT count as crossing a brick.
// The line must be drawn from top to bottom without going through the edges of the wall.
function "brick_wall" {
  description = "Finds the minimum number of crossed bricks when drawing a vertical line"
  
  input {
    json wall
  }
  
  stack {
    // Edge case: empty wall
    conditional {
      if (($input.wall|count) == 0) {
        return { value = 0 }
      }
    }
    
    var $edge_counts { value = {} }
    var $max_edges { value = 0 }
    
    // Process each row to find edge positions
    foreach ($input.wall) {
      each as $row {
        var $position { value = 0 }
        var $row_length { value = $row|count }
        var $brick_index { value = 0 }
        
        // Sum up brick widths to find edge positions
        // Don't include the last edge (right edge of wall)
        foreach ($row) {
          each as $brick_width {
            // Skip the last brick in each row (wall edge)
            conditional {
              if ($brick_index < ($row_length - 1)) {
                // Move position to the edge after this brick
                var.update $position { value = $position + $brick_width }
                
                // Count this edge position
                var $position_text { value = $position|to_text }
                var $current_count { value = 0 }
                
                // Get current count for this edge position
                conditional {
                  if ($edge_counts|has:$position_text) {
                    var $current_count {
                      value = $edge_counts|get:$position_text
                    }
                  }
                }
                
                // Increment and store the count
                var $new_count { value = $current_count + 1 }
                var $edge_counts {
                  value = $edge_counts|set:$position_text:$new_count
                }
                
                // Track maximum edge count
                conditional {
                  if ($new_count > $max_edges) {
                    var $max_edges { value = $new_count }
                  }
                }
              }
            }
            
            var.update $brick_index { value = $brick_index + 1 }
          }
        }
      }
    }
    
    // Minimum bricks crossed = total rows - max edges at any position
    var $total_rows { value = $input.wall|count }
    var $min_crossed { value = $total_rows - $max_edges }
  }
  
  response = $min_crossed
}
