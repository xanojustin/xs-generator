// Find Smallest Letter Greater Than Target
// Given a sorted array of letters and a target letter, return the smallest letter
// that is larger than the target. If target >= all letters, wrap to first letter.
// Uses binary search for O(log n) time complexity.
function "find_smallest_letter_greater_than_target" {
  description = "Finds the smallest letter greater than target in a sorted array"

  input {
    text[] letters { description = "Sorted array of lowercase letters (ascending order)" }
    text target { description = "Target letter to find next greater letter for" }
  }

  stack {
    // Get the length of the letters array
    var $n { value = $input.letters|count }
    
    // Initialize binary search boundaries
    var $left { value = 0 }
    var $right { value = $n - 1 }
    
    // Binary search to find position where target would be inserted
    while ($left <= $right) {
      each {
        // Calculate middle index (avoid potential overflow)
        var $mid { value = $left + (($right - $left) / 2) }
        var $mid_letter { value = $input.letters[$mid] }
        
        conditional {
          // Current letter is greater than target, search left half
          if ($mid_letter > $input.target) {
            var $right { value = $mid - 1 }
          }
          // Current letter <= target, search right half
          else {
            var $left { value = $mid + 1 }
          }
        }
      }
    }
    
    // left now points to the first letter > target
    // If left is beyond the array, wrap around to index 0
    conditional {
      if ($left < $n) {
        // Found a letter greater than target within bounds
        var $result { value = $input.letters[$left] }
      }
      else {
        // Target is >= all letters, wrap to first letter
        var $result { value = $input.letters[0] }
      }
    }
  }

  response = $result
}
