// Magic Index Finder
// A magic index is an index i such that arr[i] == i
// This implementation uses a modified binary search for O(log n) time complexity
// Works on sorted arrays with distinct elements
function "magic_index" {
  description = "Find a magic index in a sorted array where arr[i] == i"
  
  input {
    int[] nums { description = "Sorted array of distinct integers" }
  }
  
  stack {
    // Handle empty array
    conditional {
      if (($input.nums|count) == 0) {
        return { value = null }
      }
    }
    
    // Initialize binary search bounds
    var $left { value = 0 }
    var $right { value = ($input.nums|count) - 1 }
    var $result { value = null }
    
    // Binary search for magic index
    while ($left <= $right) {
      each {
        // Calculate middle index
        var $mid { value = ($left + $right) / 2 }
        var $mid_value { value = $input.nums[$mid] }
        
        conditional {
          // Found magic index
          if ($mid_value == $mid) {
            var.update $result { value = $mid }
            // Continue searching left for leftmost magic index
            var.update $right { value = $mid - 1 }
          }
          // Value is greater than index, search left half
          elseif ($mid_value > $mid) {
            var.update $right { value = $mid - 1 }
          }
          // Value is less than index, search right half
          else {
            var.update $left { value = $mid + 1 }
          }
        }
      }
    }
  }
  
  response = $result
}
