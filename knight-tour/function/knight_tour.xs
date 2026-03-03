function "knight_tour" {
  description = "Find a valid knight's tour on an n x n chessboard"
  
  input {
    int n filters=min:1 { description = "Board size (n x n)" }
    int start_row filters=min:0 { description = "Starting row (0-indexed)" }
    int start_col filters=min:0 { description = "Starting column (0-indexed)" }
  }
  
  stack {
    precondition ($input.n > 0) {
      error_type = "inputerror"
      error = "Board size n must be positive"
    }
    
    precondition ($input.start_row >= 0 && $input.start_row < $input.n) {
      error_type = "inputerror"
      error = "Starting row must be within board bounds [0, n-1]"
    }
    
    precondition ($input.start_col >= 0 && $input.start_col < $input.n) {
      error_type = "inputerror"
      error = "Starting column must be within board bounds [0, n-1]"
    }
    
    var $move_offsets {
      value = [
        { row: -2, col: -1 },
        { row: -2, col: 1 },
        { row: -1, col: -2 },
        { row: -1, col: 2 },
        { row: 1, col: -2 },
        { row: 1, col: 2 },
        { row: 2, col: -1 },
        { row: 2, col: 1 }
      ]
    }
    
    var $board { value = [] }
    
    for ($input.n) {
      each as $i {
        var $row { value = [] }
        for ($input.n) {
          each as $j {
            var.update $row { value = $row|append:0 }
          }
        }
        var.update $board { value = $board|append:$row }
      }
    }
    
    var $total_squares { value = $input.n * $input.n }
    
    var $board_copy { value = $board }
    var $start_row_val { value = ($board_copy|get:$input.start_row) }
    var $updated_row { value = $start_row_val|set:$input.start_col:1 }
    var $updated_board { value = $board_copy|set:$input.start_row:$updated_row }
    
    var $solution { value = null }
    var $found { value = false }
    
    var $backtrack_stack {
      value = [
        {
          row: $input.start_row,
          col: $input.start_col,
          move_num: 1,
          board: $updated_board,
          next_move_idx: 0
        }
      ]
    }
    
    var $max_iterations { value = 1000000 }
    var $iteration { value = 0 }
    
    while ((($backtrack_stack|count) > 0) && (!$found) && ($iteration < $max_iterations)) {
      each {
        var.update $iteration { value = $iteration + 1 }
        
        var $state { value = $backtrack_stack|last }
        var $current_row { value = $state|get:"row" }
        var $current_col { value = $state|get:"col" }
        var $move_num { value = $state|get:"move_num" }
        var $current_board { value = $state|get:"board" }
        var $next_idx { value = $state|get:"next_move_idx" }
        
        conditional {
          if ($move_num == $total_squares) {
            var.update $solution { value = $current_board }
            var.update $found { value = true }
          }
        }
        
        conditional {
          if (!$found) {
            var $move_idx { value = $next_idx }
            
            while (($move_idx < 8) && (!$found)) {
              each {
                var $offset { value = $move_offsets|get:$move_idx }
                var $new_row { value = $current_row + ($offset|get:"row") }
                var $new_col { value = $current_col + ($offset|get:"col") }
                
                var $in_bounds {
                  value = ($new_row >= 0) && ($new_row < $input.n) && ($new_col >= 0) && ($new_col < $input.n)
                }
                
                conditional {
                  if ($in_bounds) {
                    var $check_row { value = $current_board|get:$new_row }
                    var $cell_value { value = $check_row|get:$new_col }
                    
                    conditional {
                      if ($cell_value == 0) {
                        var $new_board_copy { value = $current_board }
                        var $target_row { value = $new_board_copy|get:$new_row }
                        var $new_target_row { value = $target_row|set:$new_col:($move_num + 1) }
                        var $new_board { value = $new_board_copy|set:$new_row:$new_target_row }
                        
                        var $updated_state {
                          value = $state|set:"next_move_idx":($move_idx + 1)
                        }
                        var $stack_without_top { value = $backtrack_stack|slice:0:(($backtrack_stack|count) - 1) }
                        var $stack_with_updated { value = $stack_without_top|append:$updated_state }
                        
                        var $new_state {
                          value = {
                            row: $new_row,
                            col: $new_col,
                            move_num: $move_num + 1,
                            board: $new_board,
                            next_move_idx: 0
                          }
                        }
                        var.update $backtrack_stack { value = $stack_with_updated|append:$new_state }
                        
                        var.update $found { value = true }
                      }
                    }
                  }
                }
                
                conditional {
                  if (!$found) {
                    var.update $move_idx { value = $move_idx + 1 }
                  }
                }
              }
            }
            
            conditional {
              if (!$found) {
                var.update $backtrack_stack { value = $backtrack_stack|slice:0:(($backtrack_stack|count) - 1) }
              }
            }
            
            conditional {
              if ($found && ($move_num < $total_squares)) {
                var.update $found { value = false }
              }
            }
          }
        }
      }
    }
    
    var $result {
      value = {
        board_size: $input.n,
        start_position: { row: $input.start_row, col: $input.start_col },
        solution: $solution,
        found: ($solution != null)
      }
    }
  }
  
  response = $result
}
