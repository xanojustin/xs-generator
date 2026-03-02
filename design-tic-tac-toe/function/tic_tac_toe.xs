function "tic_tac_toe" {
  description = "Design Tic-Tac-Toe game with move validation and win detection"
  input {
    text operation filters=trim
    int n?
    int player?
    int row?
    int col?
    int[] board?
    int current_player?
    int n_val?
  }
  stack {
    var $result { value = {} }
    
    // Initialize game
    conditional {
      if ($input.operation == "init") {
        var $size { value = $input.n }
        var $total_cells { value = $size * $size }
        var $new_board { value = [] }
        
        // Create empty board (flattened n x n filled with 0s)
        for ($total_cells) {
          each as $i {
            var.update $new_board { value = $new_board|push:0 }
          }
        }
        
        var.update $result {
          value = {
            board: $new_board,
            n: $size,
            current_player: 1,
            winner: 0,
            game_over: false
          }
        }
      }
    }
    
    // Make a move
    conditional {
      if ($input.operation == "move") {
        var $board { value = $input.board }
        var $n { value = $input.n }
        var $player { value = $input.player }
        var $row { value = $input.row }
        var $col { value = $input.col }
        
        // Validate move
        precondition ($row >= 0 && $row < $n && $col >= 0 && $col < $n) {
          error_type = "inputerror"
          error = "Invalid move: position out of bounds"
        }
        
        var $cell_index { value = $row * $n + $col }
        var $cell { value = $board|get:$cell_index }
        precondition ($cell == 0) {
          error_type = "inputerror"
          error = "Invalid move: cell already occupied"
        }
        
        // Make the move
        var.update $board { value = $board|set:$cell_index:$player }
        
        // Check for win
        var $winner { value = 0 }
        
        // Check row
        var $row_win { value = true }
        var $col_idx { value = 0 }
        for ($n) {
          each as $c {
            var $idx { value = $row * $n + $c }
            var $cell_val { value = $board|get:$idx }
            conditional {
              if ($cell_val != $player) {
                var.update $row_win { value = false }
              }
            }
          }
        }
        conditional {
          if ($row_win) {
            var.update $winner { value = $player }
          }
        }
        
        // Check column (if no row win)
        conditional {
          if ($winner == 0) {
            var $col_win { value = true }
            var $row_idx { value = 0 }
            for ($n) {
              each as $r {
                var $idx { value = $r * $n + $col }
                var $cell_at_col { value = $board|get:$idx }
                conditional {
                  if ($cell_at_col != $player) {
                    var.update $col_win { value = false }
                  }
                }
              }
            }
            conditional {
              if ($col_win) {
                var.update $winner { value = $player }
              }
            }
          }
        }
        
        // Check diagonal (top-left to bottom-right) - if position is on diagonal
        conditional {
          if ($winner == 0 && $row == $col) {
            var $diag_win { value = true }
            var $diag_idx { value = 0 }
            for ($n) {
              each as $i {
                var $idx { value = $i * $n + $i }
                var $diag_cell { value = $board|get:$idx }
                conditional {
                  if ($diag_cell != $player) {
                    var.update $diag_win { value = false }
                  }
                }
              }
            }
            conditional {
              if ($diag_win) {
                var.update $winner { value = $player }
              }
            }
          }
        }
        
        // Check anti-diagonal (top-right to bottom-left) - if position is on anti-diagonal
        conditional {
          if ($winner == 0 && $row + $col == $n - 1) {
            var $anti_diag_win { value = true }
            var $anti_idx { value = 0 }
            for ($n) {
              each as $i {
                var $col_pos { value = $n - 1 - $i }
                var $idx { value = $i * $n + $col_pos }
                var $anti_diag_cell { value = $board|get:$idx }
                conditional {
                  if ($anti_diag_cell != $player) {
                    var.update $anti_diag_win { value = false }
                  }
                }
              }
            }
            conditional {
              if ($anti_diag_win) {
                var.update $winner { value = $player }
              }
            }
          }
        }
        
        // Switch player if no winner
        var $next_player { value = $input.current_player }
        conditional {
          if ($winner == 0) {
            var.update $next_player { value = $input.current_player == 1 ? 2 : 1 }
          }
        }
        
        var.update $result {
          value = {
            board: $board,
            n: $n,
            current_player: $next_player,
            winner: $winner,
            game_over: $winner != 0
          }
        }
      }
    }
  }
  response = $result
}