function "pascals-triangle" {
  description = "Generate Pascal's Triangle with the specified number of rows"
  input {
    int num_rows filters=min:1|max:30 {
      description = "The number of rows to generate (must be >= 1, max 30 to prevent overflow)"
    }
  }
  stack {
    // Initialize the triangle with the first row
    var $triangle { value = [[1]] }

    // If only 1 row requested, return early
    conditional {
      if ($input.num_rows == 1) {
        // Triangle already initialized with first row
      }
      else {
        // Generate each subsequent row
        var $row_index { value = 1 }

        while ($row_index < $input.num_rows) {
          each {
            // Get the previous row
            var $prev_row { value = $triangle[($row_index - 1)] }
            var $prev_row_length { value = $prev_row|count }

            // Start the new row with 1
            var $new_row { value = [1] }

            // Calculate middle elements (sum of two elements above)
            var $col_index { value = 1 }

            while ($col_index < $prev_row_length) {
              each {
                var $sum {
                  value = $prev_row[($col_index - 1)] + $prev_row[$col_index]
                }
                var.update $new_row {
                  value = $new_row|push:$sum
                }
                var.update $col_index { value = $col_index + 1 }
              }
            }

            // End the row with 1
            var.update $new_row {
              value = $new_row|push:1
            }

            // Add the new row to the triangle
            var.update $triangle {
              value = $triangle|push:$new_row
            }

            var.update $row_index { value = $row_index + 1 }
          }
        }
      }
    }
  }
  response = $triangle
}
