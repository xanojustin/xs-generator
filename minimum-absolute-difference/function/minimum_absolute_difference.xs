// Minimum Absolute Difference
// Given an array of integers, find the minimum absolute difference 
// between any two elements in the array
function "minimum_absolute_difference" {
  description = "Finds the minimum absolute difference between any two elements"
  
  input {
    int[] nums { description = "Array of integers" }
  }
  
  stack {
    var $min_diff { value = 0 }
    var $sorted { value = $input.nums|sort }
    var $len { value = $input.nums|count }
    
    conditional {
      // Need at least 2 elements to have a difference
      if ($len < 2) {
        var $min_diff { value = 0 }
      }
      else {
        // Initialize with difference between first two elements
        var $sorted_array { value = $sorted }
        var $first { value = $sorted_array|first }
        var $rest { value = $sorted_array|slice:1 }
        var $second { value = $rest|first }
        var $min_diff { value = $second - $first }
        
        // Iterate through adjacent pairs to find minimum
        var $i { value = 1 }
        var $n { value = $len - 1 }
        
        while ($i < $n) {
          each {
            var $current { value = $sorted_array|slice:$i|first }
            var $next { value = $sorted_array|slice:($i + 1)|first }
            var $diff { value = $next - $current }
            
            conditional {
              if ($diff < $min_diff) {
                var $min_diff { value = $diff }
              }
            }
            
            var.update $i { value = $i + 1 }
          }
        }
      }
    }
  }
  
  response = $min_diff
}
