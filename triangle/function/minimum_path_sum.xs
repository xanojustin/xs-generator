function "minimum_path_sum" {
  description = "Given a triangle array, find the minimum path sum from top to bottom. Each step you may move to adjacent numbers on the row below."
  input {
    json triangle { description = "A 2D array representing the triangle structure" }
  }
  stack {
    // Handle edge case of empty triangle
    conditional {
      if (`$input.triangle|count == 0`) {
        return { value = 0 }
      }
    }

    // Handle case of single row
    conditional {
      if (`$input.triangle|count == 1`) {
        return { value = $input.triangle[0][0] }
      }
    }

    // Use dynamic programming - work from bottom to top
    // Start with a copy of the last row as our dp array
    var $last_row_index { value = ($input.triangle|count) - 1 }
    var $dp { value = $input.triangle[$last_row_index] }

    // Work from second-to-last row up to the top
    var $row_index { value = $last_row_index - 1 }

    while ($row_index >= 0) {
      each {
        // Get the current row
        var $current_row { value = $input.triangle[$row_index] }

        // For each element in the current row, add the minimum of the two adjacent elements below
        var $col_index { value = 0 }
        var $new_dp { value = [] }

        while ($col_index <= $row_index) {
          each {
            var $current_value { value = $current_row[$col_index] }
            var $left_below { value = $dp[$col_index] }
            var $right_below { value = $dp[$col_index + 1] }

            // Find minimum of the two below
            var $min_below { value = $left_below }
            conditional {
              if ($right_below < $left_below) {
                var.update $min_below { value = $right_below }
              }
            }

            // Add to new dp array
            var $path_sum { value = $current_value + $min_below }
            var.update $new_dp { value = $new_dp ~ [$path_sum] }

            // Move to next column
            var.update $col_index { value = $col_index + 1 }
          }
        }

        // Update dp for next iteration
        var.update $dp { value = $new_dp }

        // Move to previous row
        var.update $row_index { value = $row_index - 1 }
      }
    }

    // Store result in a variable for response
    var $result { value = $dp[0] }
  }
  response = $result
}
