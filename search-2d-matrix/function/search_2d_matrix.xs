// Search a 2D Matrix - Classic coding exercise
// Given an m x n matrix where each row and column is sorted in ascending order,
// search for a target value and return true if found, false otherwise.
// Uses the "search from top-right corner" approach for O(m + n) time complexity.
function "search_2d_matrix" {
  description = "Searches for a target value in a sorted 2D matrix"

  input {
    json matrix { description = "2D array of integers (matrix), sorted by row and column" }
    int target { description = "Target value to search for" }
  }

  stack {
    // Get matrix dimensions
    var $rows { value = $input.matrix|count }
    var $result { value = false }

    // Handle empty matrix edge case
    conditional {
      if ($rows == 0) {
        var $result { value = false }
      }
      else {
        var $cols { value = $input.matrix[0]|count }

        // Handle empty row edge case
        conditional {
          if ($cols == 0) {
            var $result { value = false }
          }
          else {
            // Start from top-right corner
            var $row { value = 0 }
            var $col { value = $cols - 1 }
            var $found { value = false }

            // Search while within bounds and not found
            while (($row < $rows) && ($col >= 0) && !$found) {
              each {
                var $current { value = $input.matrix[$row][$col] }

                conditional {
                  // Found the target
                  if ($current == $input.target) {
                    var $found { value = true }
                    var $result { value = true }
                  }
                  // Current is greater than target, move left
                  elseif ($current > $input.target) {
                    var $col { value = $col - 1 }
                  }
                  // Current is less than target, move down
                  else {
                    var $row { value = $row + 1 }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  response = $result
}
