// Toeplitz Matrix - Matrix traversal exercise
// A matrix is Toeplitz if every diagonal from top-left to bottom-right has the same element
function "is_toeplitz" {
  description = "Checks if a matrix is Toeplitz (all diagonals have same element)"

  input {
    json matrix { description = "2D array of integers representing the matrix" }
  }

  stack {
    var $rows { value = $input.matrix|count }
    var $cols { value = ($input.matrix|first)|count }
    var $is_toeplitz { value = true }

    // Check each element (except first row and first column)
    // Each element should equal the element diagonally up-left
    var $i { value = 1 }

    while (($i < $rows) && $is_toeplitz) {
      each {
        var $j { value = 1 }

        while (($j < $cols) && $is_toeplitz) {
          each {
            // Get current element
            var $current { value = $input.matrix[$i][$j] }
            // Get element diagonally up-left
            var $diagonal { value = $input.matrix[$i - 1][$j - 1] }

            conditional {
              if ($current != $diagonal) {
                var $is_toeplitz { value = false }
              }
            }

            var.update $j { value = $j + 1 }
          }
        }

        var.update $i { value = $i + 1 }
      }
    }
  }

  response = $is_toeplitz
}
