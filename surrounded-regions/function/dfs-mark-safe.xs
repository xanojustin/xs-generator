// Helper function to mark all connected O's starting from (row, col) as safe
function "dfs-mark-safe" {
  description = "DFS to mark all O's connected to border as safe"
  
  input {
    json board
    json visited
    int row
    int col
    int rows
    int cols
  }
  
  stack {
    // Base cases: out of bounds, already visited, or not an O
    conditional {
      if ($input.row < 0 || $input.row >= $input.rows || $input.col < 0 || $input.col >= $input.cols) {
        return { value = $input.visited }
      }
    }
    
    conditional {
      if ($input.visited[$input.row][$input.col]) {
        return { value = $input.visited }
      }
    }
    
    conditional {
      if ($input.board[$input.row][$input.col] != "O") {
        return { value = $input.visited }
      }
    }
    
    // Mark current cell as visited (safe)
    function.run "set-visited" {
      input = {
        visited: $input.visited,
        row: $input.row,
        col: $input.col,
        value: true,
        rows: $input.rows,
        cols: $input.cols
      }
    } as $new_visited
    
    // Recursively mark all 4 directions
    function.run "dfs-mark-safe" {
      input = {
        board: $input.board,
        visited: $new_visited,
        row: $input.row - 1,
        col: $input.col,
        rows: $input.rows,
        cols: $input.cols
      }
    } as $up
    
    function.run "dfs-mark-safe" {
      input = {
        board: $input.board,
        visited: $up,
        row: $input.row + 1,
        col: $input.col,
        rows: $input.rows,
        cols: $input.cols
      }
    } as $down
    
    function.run "dfs-mark-safe" {
      input = {
        board: $input.board,
        visited: $down,
        row: $input.row,
        col: $input.col - 1,
        rows: $input.rows,
        cols: $input.cols
      }
    } as $left
    
    function.run "dfs-mark-safe" {
      input = {
        board: $input.board,
        visited: $left,
        row: $input.row,
        col: $input.col + 1,
        rows: $input.rows,
        cols: $input.cols
      }
    } as $right
    
    return { value = $right }
  }
  
  response = $output
}
