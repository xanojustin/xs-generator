// Binary Search - Classic coding exercise
// Given a sorted array and a target value, return the index of the target
// Uses iterative binary search for O(log n) time complexity
function "binary_search" {
  description = "Finds the index of a target value in a sorted array using binary search"

  input {
    int[] nums { description = "Sorted array of integers (ascending order)" }
    int target { description = "Target value to search for" }
  }

  stack {
    // Initialize search boundaries
    var $left { value = 0 }
    var $right { value = ($input.nums|count) - 1 }
    var $result { value = -1 }
    var $found { value = false }

    // Binary search loop
    while (($left <= $right) && !$found) {
      each {
        // Calculate middle index (avoid potential overflow)
        var $mid { value = $left + (($right - $left) / 2) }
        var $mid_value { value = $input.nums[$mid] }

        conditional {
          // Target found at mid index
          if ($mid_value == $input.target) {
            var $result { value = $mid }
            var $found { value = true }
          }
          // Target is in the right half
          elseif ($mid_value < $input.target) {
            var $left { value = $mid + 1 }
          }
          // Target is in the left half
          else {
            var $right { value = $mid - 1 }
          }
        }
      }
    }
  }

  response = $result
}
