// Valid Sudoku - Check if a 9x9 Sudoku board is valid
// Validates that no row, column, or 3x3 box contains duplicate numbers
function "valid_sudoku" {
  description = "Validates a 9x9 Sudoku board"

  input {
    json board { description = "9x9 grid where 0 represents empty cells" }
  }

  stack {
    var $is_valid { value = true }
    var $row { value = 0 }

    // Check rows for duplicates
    while (`$row < 9 && $is_valid`) {
      each {
        var $seen { value = [] }
        var $col { value = 0 }
        var $current_row { value = $input.board|get:($row|to_text) }
        while (`$col < 9 && $is_valid`) {
          each {
            var $cell { value = $current_row|get:($col|to_text) }
            conditional {
              if (`$cell > 0`) {
                conditional {
                  if ($seen|contains:$cell) {
                    var $is_valid { value = false }
                  }
                  else {
                    var $seen { value = $seen|merge:[$cell] }
                  }
                }
              }
            }
            var.update $col { value = $col + 1 }
          }
        }
        var.update $row { value = $row + 1 }
      }
    }

    // Check columns for duplicates
    conditional {
      if ($is_valid) {
        var $col { value = 0 }
        while (`$col < 9 && $is_valid`) {
          each {
            var $seen { value = [] }
            var $row { value = 0 }
            while (`$row < 9 && $is_valid`) {
              each {
                var $current_row { value = $input.board|get:($row|to_text) }
                var $cell { value = $current_row|get:($col|to_text) }
                conditional {
                  if (`$cell > 0`) {
                    conditional {
                      if ($seen|contains:$cell) {
                        var $is_valid { value = false }
                      }
                      else {
                        var $seen { value = $seen|merge:[$cell] }
                      }
                    }
                  }
                }
                var.update $row { value = $row + 1 }
              }
            }
            var.update $col { value = $col + 1 }
          }
        }
      }
    }

    // Check 3x3 boxes for duplicates
    conditional {
      if ($is_valid) {
        var $box_row { value = 0 }
        while (`$box_row < 3 && $is_valid`) {
          each {
            var $box_col { value = 0 }
            while (`$box_col < 3 && $is_valid`) {
              each {
                var $seen { value = [] }
                var $inner_row { value = 0 }
                while (`$inner_row < 3 && $is_valid`) {
                  each {
                    var $inner_col { value = 0 }
                    while (`$inner_col < 3 && $is_valid`) {
                      each {
                        var $actual_row { value = ($box_row * 3) + $inner_row }
                        var $actual_col { value = ($box_col * 3) + $inner_col }
                        var $current_row { value = $input.board|get:($actual_row|to_text) }
                        var $cell { value = $current_row|get:($actual_col|to_text) }
                        conditional {
                          if (`$cell > 0`) {
                            conditional {
                              if ($seen|contains:$cell) {
                                var $is_valid { value = false }
                              }
                              else {
                                var $seen { value = $seen|merge:[$cell] }
                              }
                            }
                          }
                        }
                        var.update $inner_col { value = $inner_col + 1 }
                      }
                    }
                    var.update $inner_row { value = $inner_row + 1 }
                  }
                }
                var.update $box_col { value = $box_col + 1 }
              }
            }
            var.update $box_row { value = $box_row + 1 }
          }
        }
      }
    }
  }

  response = $is_valid
}
