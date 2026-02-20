// Matrix Transpose - Classic matrix operation
// Transposes a 2D matrix (converts rows to columns and columns to rows)
function "matrix_transpose" {
  description = "Transposes a 2D matrix (rows become columns, columns become rows)"

  input {
    json matrix { description = "2D array of integers representing the matrix to transpose" }
  }

  stack {
    // Get dimensions of the input matrix
    var $rows { value = $input.matrix|count }
    var $cols { value = 0 }

    // Handle empty matrix edge case
    conditional {
      if ($rows > 0) {
        var $cols { value = $input.matrix[0]|count }
      }
    }

    // Initialize result matrix with swapped dimensions (cols x rows)
    var $result { value = [] }

    // Iterate through each column of the original matrix
    // This becomes the rows of the transposed matrix
    var $col { value = 0 }
    while ($col < $cols) {
      each {
        // Create a new row for the transposed matrix
        var $new_row { value = [] }

        // Iterate through each row of the original matrix
        // This becomes the columns of the transposed matrix
        var $row { value = 0 }
        while ($row < $rows) {
          each {
            // Push the element at (row, col) to the new row
            array.push $new_row {
              value = $input.matrix[$row][$col]
            }
            math.add $row { value = 1 }
          }
        }

        // Push the completed new row to the result
        array.push $result {
          value = $new_row
        }
        math.add $col { value = 1 }
      }
    }
  }

  response = $result
}
