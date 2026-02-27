function "longest_increasing_path" {
  description = "Find the longest increasing path in a matrix using DFS with memoization"
  input {
    json matrix
  }
  stack {
    var $rows { value = $input.matrix|count }
    var $cols { value = ($input.matrix|count) > 0 ? ($input.matrix|first|count) : 0 }
    
    // Edge case: empty matrix
    conditional {
      if ($rows == 0 || $cols == 0) {
        return { value = 0 }
      }
    }
    
    // Initialize memoization cache with -1 (uncomputed)
    var $memo { value = [] }
    for ($rows) {
      each as $i {
        var $row { value = [] }
        for ($cols) {
          each as $j {
            var.update $row { value = $row|append:(-1) }
          }
        }
        var.update $memo { value = $memo|append:$row }
      }
    }
    
    // Direction vectors: up, down, left, right
    var $dirs { value = [[-1, 0], [1, 0], [0, -1], [0, 1]] }
    
    // Variable to track the longest path found
    var $max_length { value = 0 }
    
    // Helper to update memo at position [r][c]
    // We rebuild the row with the updated value
    
    // Try each cell as a starting point
    for ($rows) {
      each as $r {
        for ($cols) {
          each as $c {
            // Check if already computed
            var $memo_val { value = $memo|get:$r|get:$c }
            
            conditional {
              if ($memo_val != -1) {
                // Already computed, update max if needed
                conditional {
                  if ($memo_val > $max_length) {
                    var.update $max_length { value = $memo_val }
                  }
                }
              }
              else {
                // Need to compute DFS from this cell
                var $stack { value = [[$r, $c, 1]] }
                var $local_max { value = 1 }
                
                while (($stack|count) > 0) {
                  each {
                    // Pop from stack: [row, col, length]
                    var $curr { value = $stack|last }
                    var $curr_row { value = $curr|get:0 }
                    var $curr_col { value = $curr|get:1 }
                    var $curr_len { value = $curr|get:2 }
                    
                    var.update $stack { value = $stack|slice:0:-1 }
                    
                    conditional {
                      if ($curr_len > $local_max) {
                        var.update $local_max { value = $curr_len }
                      }
                    }
                    
                    // Explore all 4 directions
                    foreach ($dirs) {
                      each as $dir {
                        var $nr { value = $curr_row + ($dir|get:0) }
                        var $nc { value = $curr_col + ($dir|get:1) }
                        
                        // Check bounds
                        conditional {
                          if ($nr >= 0 && $nr < $rows && $nc >= 0 && $nc < $cols) {
                            // Check if next cell has greater value
                            var $curr_val { value = $input.matrix|get:$curr_row|get:$curr_col }
                            var $next_val { value = $input.matrix|get:$nr|get:$nc }
                            
                            conditional {
                              if ($next_val > $curr_val) {
                                // Check if we should visit (not memoized yet or better path)
                                var $next_memo { value = $memo|get:$nr|get:$nc }
                                conditional {
                                  if ($next_memo == -1 || $next_memo < $curr_len + 1) {
                                    // Update memo by rebuilding the row
                                    var $old_row { value = $memo|get:$nr }
                                    var $new_row { value = [] }
                                    var $col_idx { value = 0 }
                                    foreach ($old_row) {
                                      each as $old_val {
                                        conditional {
                                          if ($col_idx == $nc) {
                                            var.update $new_row { value = $new_row|append:($curr_len + 1) }
                                          }
                                          else {
                                            var.update $new_row { value = $new_row|append:$old_val }
                                          }
                                        }
                                        var.update $col_idx { value = $col_idx + 1 }
                                      }
                                    }
                                    // Rebuild memo with new row
                                    var $new_memo { value = [] }
                                    var $row_idx { value = 0 }
                                    foreach ($memo) {
                                      each as $memo_row {
                                        conditional {
                                          if ($row_idx == $nr) {
                                            var.update $new_memo { value = $new_memo|append:$new_row }
                                          }
                                          else {
                                            var.update $new_memo { value = $new_memo|append:$memo_row }
                                          }
                                        }
                                        var.update $row_idx { value = $row_idx + 1 }
                                      }
                                    }
                                    var.update $memo { value = $new_memo }
                                    
                                    var.update $stack { value = $stack|append:[[$nr, $nc, $curr_len + 1]] }
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
                
                // Update memo for starting cell by rebuilding
                var $start_row { value = $memo|get:$r }
                var $new_start_row { value = [] }
                var $start_col_idx { value = 0 }
                foreach ($start_row) {
                  each as $start_val {
                    conditional {
                      if ($start_col_idx == $c) {
                        var.update $new_start_row { value = $new_start_row|append:$local_max }
                      }
                      else {
                        var.update $new_start_row { value = $new_start_row|append:$start_val }
                      }
                    }
                    var.update $start_col_idx { value = $start_col_idx + 1 }
                  }
                }
                // Rebuild memo with updated start row
                var $final_memo { value = [] }
                var $final_row_idx { value = 0 }
                foreach ($memo) {
                  each as $final_memo_row {
                    conditional {
                      if ($final_row_idx == $r) {
                        var.update $final_memo { value = $final_memo|append:$new_start_row }
                      }
                      else {
                        var.update $final_memo { value = $final_memo|append:$final_memo_row }
                      }
                    }
                    var.update $final_row_idx { value = $final_row_idx + 1 }
                  }
                }
                var.update $memo { value = $final_memo }
                
                conditional {
                  if ($local_max > $max_length) {
                    var.update $max_length { value = $local_max }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  response = $max_length
}
