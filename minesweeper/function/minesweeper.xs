// Minesweeper - Classic matrix problem
// Reveals cells on a minesweeper board based on click position
function "minesweeper" {
  description = "Reveals cells on a minesweeper board after a click"

  input {
    json board { description = "2D array representing the board: 'M' = unrevealed mine, 'E' = unrevealed empty, 'B' = revealed blank, '1'-'8' = revealed with mine count, 'X' = revealed mine" }
    json click { description = "Array [row, col] representing the click position" }
  }

  stack {
    // Extract click coordinates
    var $click_row { value = $input.click[0] }
    var $click_col { value = $input.click[1] }
    var $rows { value = $input.board|count }
    var $cols { value = $input.board[0]|count }
    
    // Create a copy of the board to modify
    var $result_board { value = $input.board }
    var $cell { value = $input.board[$click_row][$click_col] }
    
    // If clicked on a mine, game over - mark as X
    conditional {
      if ($cell == "M") {
        var.update $result_board[$click_row] {
          value = $result_board[$click_row]|set:$click_col:"X"
        }
        return { value = $result_board }
      }
    }
    
    // If already revealed, return as is
    conditional {
      if ($cell != "E") {
        return { value = $result_board }
      }
    }
    
    // Reveal the cell and adjacent cells if needed
    function.run "reveal_cell" {
      input = {
        board: $result_board,
        row: $click_row,
        col: $click_col,
        rows: $rows,
        cols: $cols
      }
    } as $reveal_result
    
    var $result_board { value = $reveal_result }
  }

  response = $result_board
}
