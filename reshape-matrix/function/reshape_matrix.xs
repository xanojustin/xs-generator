// Reshape Matrix - Classic array manipulation exercise
// Reshapes a matrix to new dimensions if element count matches
function "reshape_matrix" {
  description = "Reshapes a matrix to new dimensions r x c"

  input {
    json mat { description = "Input matrix (2D array of integers)" }
    int r { description = "Target number of rows" }
    int c { description = "Target number of columns" }
  }

  stack {
    // Calculate original dimensions
    var $orig_rows { value = $input.mat|count }
    var $orig_cols { value = 0 }

    conditional {
      if ($orig_rows > 0) {
        var $first_row { value = $input.mat|first }
        var $orig_cols { value = $first_row|count }
      }
    }

    var $orig_total { value = $orig_rows * $orig_cols }
    var $new_total { value = $input.r * $input.c }

    // If dimensions don't match, return original matrix
    conditional {
      if ($orig_total != $new_total) {
        return { value = $input.mat }
      }
    }

    // Flatten the matrix into a 1D array
    var $flat { value = [] }

    foreach ($input.mat) {
      each as $row {
        foreach ($row) {
          each as $val {
            var $flat {
              value = $flat|merge:[$val]
            }
          }
        }
      }
    }

    // Build the reshaped matrix
    var $result { value = [] }
    var $idx { value = 0 }

    while (($idx|count) < $input.r) {
      each {
        var $new_row { value = [] }
        var $col_idx { value = 0 }

        while ($col_idx < $input.c) {
          each {
            // Calculate the flat index: idx * c + col_idx
            var $flat_idx { value = ($idx * $input.c) + $col_idx }
            var $val { value = $flat[$flat_idx] }
            var $new_row {
              value = $new_row|merge:[$val]
            }
            var.update $col_idx { value = $col_idx + 1 }
          }
        }

        var $result {
          value = $result|merge:[$new_row]
        }
        var.update $idx { value = $idx + 1 }
      }
    }
  }

  response = $result
}
