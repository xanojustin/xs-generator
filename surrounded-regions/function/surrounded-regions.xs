// Surrounded Regions - DFS/BFS grid problem
// Given a board with 'X' and 'O', capture all regions surrounded by 'X'
// by flipping all 'O's into 'X's in that surrounded region.
// Regions connected to the border are NOT surrounded.
function "surrounded-regions" {
  description = "Captures all regions surrounded by X by flipping O's to X's"
  
  input {
    json board { description = "2D grid containing 'X' and 'O' characters" }
  }
  
  stack {
    // Handle empty board
    var $rows { value = $input.board|count }
    
    conditional {
      if ($rows == 0) {
        return { value = $input.board }
      }
    }
    
    var $cols { value = ($input.board|first)|count }
    
    // Handle single row or column - nothing can be surrounded
    conditional {
      if ($rows <= 1 || $cols <= 1) {
        return { value = $input.board }
      }
    }
    
    // Track visited cells with a boolean grid
    var $visited { value = [] }
    var $r { value = 0 }
    while ($r < $rows) {
      each {
        var $row_visited { value = [] }
        var $c { value = 0 }
        while ($c < $cols) {
          each {
            var $row_visited { value = $row_visited|merge:[false] }
            var.update $c { value = $c + 1 }
          }
        }
        var $visited { value = $visited|merge:[$row_visited] }
        var.update $r { value = $r + 1 }
      }
    }
    
    // Mark all O's connected to top and bottom borders as safe using DFS
    var $col { value = 0 }
    while ($col < $cols) {
      each {
        // Top border
        conditional {
          if ($input.board[0][$col] == "O") {
            function.run "dfs-mark-safe" {
              input = {
                board: $input.board,
                visited: $visited,
                row: 0,
                col: $col,
                rows: $rows,
                cols: $cols
              }
            } as $visited_result
            var $visited { value = $visited_result }
          }
        }
        // Bottom border
        conditional {
          if ($input.board[$rows - 1][$col] == "O") {
            function.run "dfs-mark-safe" {
              input = {
                board: $input.board,
                visited: $visited,
                row: $rows - 1,
                col: $col,
                rows: $rows,
                cols: $cols
              }
            } as $visited_result
            var $visited { value = $visited_result }
          }
        }
        var.update $col { value = $col + 1 }
      }
    }
    
    // Check left and right borders
    var $row { value = 0 }
    while ($row < $rows) {
      each {
        // Left border
        conditional {
          if ($input.board[$row][0] == "O") {
            function.run "dfs-mark-safe" {
              input = {
                board: $input.board,
                visited: $visited,
                row: $row,
                col: 0,
                rows: $rows,
                cols: $cols
              }
            } as $visited_result
            var $visited { value = $visited_result }
          }
        }
        // Right border
        conditional {
          if ($input.board[$row][$cols - 1] == "O") {
            function.run "dfs-mark-safe" {
              input = {
                board: $input.board,
                visited: $visited,
                row: $row,
                col: $cols - 1,
                rows: $rows,
                cols: $cols
              }
            } as $visited_result
            var $visited { value = $visited_result }
          }
        }
        var.update $row { value = $row + 1 }
      }
    }
    
    // Build result - flip unvisited O's to X's
    var $result { value = [] }
    var $i { value = 0 }
    while ($i < $rows) {
      each {
        var $result_row { value = [] }
        var $j { value = 0 }
        while ($j < $cols) {
          each {
            conditional {
              if ($input.board[$i][$j] == "O" && !$visited[$i][$j]) {
                // This O is surrounded - flip to X
                var $result_row { value = $result_row|merge:["X"] }
              }
              else {
                // Keep original value (either X or safe O)
                var $result_row { value = $result_row|merge:[$input.board[$i][$j]] }
              }
            }
            var.update $j { value = $j + 1 }
          }
        }
        var $result { value = $result|merge:[$result_row] }
        var.update $i { value = $i + 1 }
      }
    }
    
    return { value = $result }
  }
  
  response = $output
}
