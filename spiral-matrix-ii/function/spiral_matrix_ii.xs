function "spiral_matrix_ii" {
  description = "Generate an n x n matrix filled with numbers 1 to n² in spiral order"
  input {
    int n filters=min:1
  }
  stack {
    // Initialize n x n matrix filled with zeros
    var $matrix {
      value = []
    }
    
    // Create empty matrix rows
    for ($input.n) {
      each as $i {
        var $row {
          value = []
        }
        for ($input.n) {
          each as $j {
            var.update $row {
              value = $row|merge:0
            }
          }
        }
        var.update $matrix {
          value = $matrix|merge:$row
        }
      }
    }
    
    // Define boundaries
    var $top {
      value = 0
    }
    var $bottom {
      value = $input.n - 1
    }
    var $left {
      value = 0
    }
    var $right {
      value = $input.n - 1
    }
    
    // Current number to place (1 to n²)
    var $num {
      value = 1
    }
    
    // Fill matrix in spiral order
    while ($top <= $bottom && $left <= $right) {
      each {
        // Traverse right along top row
        var $col {
          value = $left
        }
        while ($col <= $right) {
          each {
            var $row {
              value = $matrix|get:$top
            }
            var.update $row {
              value = $row|set:($col|to_text):$num
            }
            var.update $matrix {
              value = $matrix|set:($top|to_text):$row
            }
            var.update $num {
              value = $num + 1
            }
            var.update $col {
              value = $col + 1
            }
          }
        }
        var.update $top {
          value = $top + 1
        }
        
        // Traverse down along right column
        var $row_idx {
          value = $top
        }
        while ($row_idx <= $bottom) {
          each {
            var $row {
              value = $matrix|get:$row_idx
            }
            var.update $row {
              value = $row|set:($right|to_text):$num
            }
            var.update $matrix {
              value = $matrix|set:($row_idx|to_text):$row
            }
            var.update $num {
              value = $num + 1
            }
            var.update $row_idx {
              value = $row_idx + 1
            }
          }
        }
        var.update $right {
          value = $right - 1
        }
        
        // Traverse left along bottom row (if still valid)
        conditional {
          if ($top <= $bottom) {
            var $col {
              value = $right
            }
            while ($col >= $left) {
              each {
                var $row {
                  value = $matrix|get:$bottom
                }
                var.update $row {
                  value = $row|set:($col|to_text):$num
                }
                var.update $matrix {
                  value = $matrix|set:($bottom|to_text):$row
                }
                var.update $num {
                  value = $num + 1
                }
                var.update $col {
                  value = $col - 1
                }
              }
            }
            var.update $bottom {
              value = $bottom - 1
            }
          }
        }
        
        // Traverse up along left column (if still valid)
        conditional {
          if ($left <= $right) {
            var $row_idx {
              value = $bottom
            }
            while ($row_idx >= $top) {
              each {
                var $row {
                  value = $matrix|get:$row_idx
                }
                var.update $row {
                  value = $row|set:($left|to_text):$num
                }
                var.update $matrix {
                  value = $matrix|set:($row_idx|to_text):$row
                }
                var.update $num {
                  value = $num + 1
                }
                var.update $row_idx {
                  value = $row_idx - 1
                }
              }
            }
            var.update $left {
              value = $left + 1
            }
          }
        }
      }
    }
  }
  response = $matrix
}
