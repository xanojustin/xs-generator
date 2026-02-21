// Search in Rotated Sorted Array - Classic coding exercise
// Given a sorted array that has been rotated at an unknown pivot,
// find the index of a target value. Runs in O(log n) time.
function "search_rotated_array" {
  description = "Finds the index of a target in a rotated sorted array using modified binary search"

  input {
    int[] nums { description = "Rotated sorted array of distinct integers" }
    int target { description = "Target value to search for" }
  }

  stack {
    // Initialize search boundaries
    var $left { value = 0 }
    var $right { value = ($input.nums|count) - 1 }
    var $result { value = -1 }
    var $found { value = false }

    // Modified binary search for rotated array
    while (($left <= $right) && !$found) {
      each {
        var $mid { value = $left + (($right - $left) / 2) }
        var $mid_value { value = $input.nums[$mid] }

        conditional {
          // Target found at mid index
          if ($mid_value == $input.target) {
            var $result { value = $mid }
            var $found { value = true }
          }
          else {
            // Determine which half is sorted
            var $left_value { value = $input.nums[$left] }
            
            conditional {
              // Left half is sorted
              if ($left_value <= $mid_value) {
                conditional {
                  // Target is in the left sorted half
                  if (($input.target >= $left_value) && ($input.target < $mid_value)) {
                    var $right { value = $mid - 1 }
                  }
                  // Target is in the right half
                  else {
                    var $left { value = $mid + 1 }
                  }
                }
              }
              // Right half is sorted
              else {
                var $right_value { value = $input.nums[$right] }
                conditional {
                  // Target is in the right sorted half
                  if (($input.target > $mid_value) && ($input.target <= $right_value)) {
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
        }
      }
    }
  }

  response = $result
}
