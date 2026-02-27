// Find First and Last Position of Element in Sorted Array
// Given a sorted array of integers and a target value,
// find the starting and ending position of the target value.
// Uses modified binary search for O(log n) time complexity.
function "find_first_last_position" {
  description = "Finds the first and last positions of a target value in a sorted array"

  input {
    int[] nums { description = "Sorted array of integers (ascending order)" }
    int target { description = "Target value to search for" }
  }

  stack {
    // Edge case: empty array
    conditional {
      if (($input.nums|count) == 0) {
        return { value = [-1, -1] }
      }
    }

    // Find first position (leftmost occurrence)
    var $first { value = -1 }
    var $left { value = 0 }
    var $right { value = ($input.nums|count) - 1 }

    while ($left <= $right) {
      each {
        var $mid { value = $left + (($right - $left) / 2) }
        var $mid_value { value = $input.nums[$mid] }

        conditional {
          if ($mid_value == $input.target) {
            var $first { value = $mid }
            var $right { value = $mid - 1 }
          }
          elseif ($mid_value < $input.target) {
            var $left { value = $mid + 1 }
          }
          else {
            var $right { value = $mid - 1 }
          }
        }
      }
    }

    // If first not found, target doesn't exist
    conditional {
      if ($first == -1) {
        return { value = [-1, -1] }
      }
    }

    // Find last position (rightmost occurrence)
    var $last { value = -1 }
    var $left { value = 0 }
    var $right { value = ($input.nums|count) - 1 }

    while ($left <= $right) {
      each {
        var $mid { value = $left + (($right - $left) / 2) }
        var $mid_value { value = $input.nums[$mid] }

        conditional {
          if ($mid_value == $input.target) {
            var $last { value = $mid }
            var $left { value = $mid + 1 }
          }
          elseif ($mid_value < $input.target) {
            var $left { value = $mid + 1 }
          }
          else {
            var $right { value = $mid - 1 }
          }
        }
      }
    }

    var $result { value = [$first, $last] }
  }

  response = $result
}
