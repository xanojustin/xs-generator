// Container With Most Water - Classic two-pointer problem
// Given an array of heights, find two lines that form a container holding the most water
// The area between two lines at indices i and j is: min(height[i], height[j]) * (j - i)
// Uses two-pointer approach for O(n) time complexity
function "container_with_most_water" {
  description = "Finds the maximum water container area from an array of heights"

  input {
    int[] heights { description = "Array of non-negative integers representing line heights" }
  }

  stack {
    // Initialize two pointers at opposite ends
    var $left { value = 0 }
    var $right { value = ($input.heights|count) - 1 }
    var $max_area { value = 0 }

    // Two-pointer approach: move the pointer with smaller height inward
    while ($left < $right) {
      each {
        // Calculate current area
        var $left_height { value = $input.heights[$left] }
        var $right_height { value = $input.heights[$right] }
        
        // Find the shorter line (water level is limited by shorter line)
        conditional {
          if ($left_height < $right_height) {
            var $min_height { value = $left_height }
          }
          else {
            var $min_height { value = $right_height }
          }
        }
        
        // Calculate width and area
        var $width { value = $right - $left }
        var $current_area { value = $min_height * $width }
        
        // Update max area if current is larger
        conditional {
          if ($current_area > $max_area) {
            var $max_area { value = $current_area }
          }
        }
        
        // Move the pointer with smaller height inward
        // (moving the taller one won't increase area since height is limited by shorter)
        conditional {
          if ($left_height < $right_height) {
            var.update $left { value = $left + 1 }
          }
          else {
            var.update $right { value = $right - 1 }
          }
        }
      }
    }
  }

  response = $max_area
}
