function "island_perimeter" {
  description = "Calculate the perimeter of an island in a 2D grid"
  input {
    // 2D grid where 1 = land, 0 = water (array of arrays)
    json grid
  }
  stack {
    var $perimeter {
      value = 0
    }
    var $rows {
      value = ($input.grid|count)
    }
    
    // Handle empty grid
    conditional {
      if ($rows == 0) {
        return { value = 0 }
      }
    }
    
    var $cols {
      value = ($input.grid|first|count)
    }
    
    // Handle empty rows
    conditional {
      if ($cols == 0) {
        return { value = 0 }
      }
    }
    
    // Iterate through each cell in the grid
    var $row_idx {
      value = 0
    }
    while ($row_idx < $rows) {
      each {
        var $col_idx {
          value = 0
        }
        while ($col_idx < $cols) {
          each {
            // Get current cell value
            var $cell {
              value = $input.grid[$row_idx][$col_idx]
            }
            
            conditional {
              if ($cell == 1) {
                // Each land cell starts with 4 sides
                var $sides {
                  value = 4
                }
                
                // Check top neighbor (subtract 1 if also land)
                conditional {
                  if ($row_idx > 0) {
                    var $top {
                      value = $input.grid[$row_idx - 1][$col_idx]
                    }
                    conditional {
                      if ($top == 1) {
                        var.update $sides {
                          value = $sides - 1
                        }
                      }
                    }
                  }
                }
                
                // Check bottom neighbor
                conditional {
                  if ($row_idx < ($rows - 1)) {
                    var $bottom {
                      value = $input.grid[$row_idx + 1][$col_idx]
                    }
                    conditional {
                      if ($bottom == 1) {
                        var.update $sides {
                          value = $sides - 1
                        }
                      }
                    }
                  }
                }
                
                // Check left neighbor
                conditional {
                  if ($col_idx > 0) {
                    var $left {
                      value = $input.grid[$row_idx][$col_idx - 1]
                    }
                    conditional {
                      if ($left == 1) {
                        var.update $sides {
                          value = $sides - 1
                        }
                      }
                    }
                  }
                }
                
                // Check right neighbor
                conditional {
                  if ($col_idx < ($cols - 1)) {
                    var $right {
                      value = $input.grid[$row_idx][$col_idx + 1]
                    }
                    conditional {
                      if ($right == 1) {
                        var.update $sides {
                          value = $sides - 1
                        }
                      }
                    }
                  }
                }
                
                // Add remaining sides to perimeter
                var.update $perimeter {
                  value = $perimeter + $sides
                }
              }
            }
            
            var.update $col_idx {
              value = $col_idx + 1
            }
          }
        }
        var.update $row_idx {
          value = $row_idx + 1
        }
      }
    }
  }
  response = $perimeter
}
