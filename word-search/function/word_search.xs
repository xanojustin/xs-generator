// Word Search - Classic backtracking problem
// Given a 2D grid of letters and a word, determine if the word exists in the grid
// The word can be constructed from adjacent cells (horizontally or vertically neighboring)
// The same letter cell may not be used more than once
function "word_search" {
  description = "Determines if a word exists in a 2D letter grid"

  input {
    json grid { description = "2D array of characters representing the board" }
    text word { description = "The word to search for in the grid" }
  }

  stack {
    // Handle empty inputs
    var $rows { value = $input.grid|count }
    conditional {
      if ($rows == 0) {
        return { value = false }
      }
    }

    var $cols { value = $input.grid[0]|count }
    conditional {
      if ($cols == 0 || ($input.word|strlen) == 0) {
        return { value = false }
      }
    }

    // Convert word to array of characters for easier access
    var $word_chars { value = $input.word|split:"" }
    var $word_len { value = $word_chars|count }

    // Helper function: Check if word exists starting from position (row, col)
    // Using iterative DFS with explicit stack to avoid recursion issues
    var $found { value = false }

    // Try starting from each cell in the grid
    var $start_row { value = 0 }
    while ($start_row < $rows && !$found) {
      each {
        var $start_col { value = 0 }
        while ($start_col < $cols && !$found) {
          each {
            // Check if first character matches
            conditional {
              if ($input.grid[$start_row][$start_col] == $word_chars[0]) {
                // Start DFS from this position
                // Stack contains: [row, col, char_index, visited_cells]
                var $dfs_stack { value = [[$start_row, $start_col, 0, []]] }

                while (($dfs_stack|count) > 0 && !$found) {
                  each {
                    array.pop $dfs_stack as $current
                    var $cr { value = $current[0] }
                    var $cc { value = $current[1] }
                    var $cidx { value = $current[2] }
                    var $cvisited { value = $current[3] }

                    // Check if we've matched the entire word
                    conditional {
                      if ($cidx == $word_len - 1) {
                        var $found { value = true }
                      }
                    }

                    conditional {
                      if (!$found) {
                        // Mark current cell as visited
                        var $cell_key { value = ($cr|to_text) ~ "," ~ ($cc|to_text) }
                        var $new_visited { value = $cvisited|merge:[$cell_key] }

                        // Explore all 4 directions: up, down, left, right
                        var $directions { value = [[-1, 0], [1, 0], [0, -1], [0, 1]] }

                        foreach ($directions) {
                          each as $dir {
                            var $nr { value = $cr + $dir[0] }
                            var $nc { value = $cc + $dir[1] }
                            var $nidx { value = $cidx + 1 }

                            // Check bounds
                            conditional {
                              if ($nr >= 0 && $nr < $rows && $nc >= 0 && $nc < $cols) {
                                // Check if cell is not visited
                                var $ncell_key { value = ($nr|to_text) ~ "," ~ ($nc|to_text) }
                                conditional {
                                  if (!($new_visited|has:$ncell_key)) {
                                    // Check if character matches next character in word
                                    conditional {
                                      if ($input.grid[$nr][$nc] == $word_chars[$nidx]) {
                                        array.push $dfs_stack {
                                          value = [$nr, $nc, $nidx, $new_visited]
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
                  }
                }
              }
            }
            math.add $start_col { value = 1 }
          }
        }
        math.add $start_row { value = 1 }
      }
    }
  }

  response = $found
}
