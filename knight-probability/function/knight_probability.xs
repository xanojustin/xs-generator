function "knight_probability" {
  description = "Calculate the probability that a knight remains on an n x n chessboard after k moves"
  
  input {
    int n { description = "Size of the chessboard (n x n)" }
    int k { description = "Number of moves the knight makes" }
    int row { description = "Starting row position" }
    int column { description = "Starting column position" }
  }
  
  stack {
    // Knight's 8 possible moves
    var $moves { value = [
      { row: 2, col: 1 },
      { row: 2, col: -1 },
      { row: -2, col: 1 },
      { row: -2, col: -1 },
      { row: 1, col: 2 },
      { row: 1, col: -2 },
      { row: -1, col: 2 },
      { row: -1, col: -2 }
    ] }
    
    // Initialize DP table: dp[step][r][c] = probability of being at (r,c) after step moves
    // Use current and next to save memory
    var $current { value = [] }
    
    // Initialize with starting position
    for ($input.n) {
      each as $r {
        var $row { value = [] }
        for ($input.n) {
          each as $c {
            var $row { 
              value = $row ~ [0.0] 
            }
          }
        }
        var $current { 
          value = $current ~ [$row] 
        }
      }
    }
    
    // Set starting position probability to 1.0
    // Rebuild the current grid with starting position set
    var $current { value = [] }
    for ($input.n) {
      each as $r {
        var $row { value = [] }
        for ($input.n) {
          each as $c {
            conditional {
              if ($r == $input.row && $c == $input.column) {
                var $row { value = $row ~ [1.0] }
              }
              else {
                var $row { value = $row ~ [0.0] }
              }
            }
          }
        }
        var $current { value = $current ~ [$row] }
      }
    }
    
    // Process each move
    for ($input.k) {
      each as $step {
        // Initialize next step probabilities to 0
        var $next { value = [] }
        for ($input.n) {
          each as $r {
            var $row { value = [] }
            for ($input.n) {
              each as $c {
                var $row { value = $row ~ [0.0] }
              }
            }
            var $next { value = $next ~ [$row] }
          }
        }
        
        // For each cell, spread probability to valid knight moves
        for ($input.n) {
          each as $r {
            for ($input.n) {
              each as $c {
                conditional {
                  if ($current[$r][$c] > 0) {
                    // Try all 8 knight moves
                    foreach ($moves) {
                      each as $move {
                        var $new_row { value = $r + $move.row }
                        var $new_col { value = $c + $move.col }
                        
                        // Check if new position is on the board
                        conditional {
                          if ($new_row >= 0 && $new_row < $input.n && $new_col >= 0 && $new_col < $input.n) {
                            // Add probability (each move has 1/8 chance)
                            var $prob_to_add { value = $current[$r][$c] / 8.0 }
                            var $next { 
                              value = $next|set:($new_row|to_text):($next[$new_row]|set:($new_col|to_text):($next[$new_row][$new_col] + $prob_to_add))
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
        }
        
        // Update current to next
        var $current { value = $next }
      }
    }
    
    // Sum all probabilities to get total probability of staying on board
    var $total_prob { value = 0.0 }
    for ($input.n) {
      each as $r {
        for ($input.n) {
          each as $c {
            var $total_prob { value = $total_prob + $current[$r][$c] }
          }
        }
      }
    }
    
    var $result { value = $total_prob }
  }
  
  response = $result
}
