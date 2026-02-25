// Dominant Index - Find the index of the largest element 
// that is at least twice as large as every other number
function "dominant_index" {
  description = "Finds index of largest element if it's at least twice all others"
  
  input {
    int[] nums { description = "Array of integers with unique largest element" }
  }
  
  stack {
    // Handle single element case
    var $result { value = -1 }
    var $len { value = $input.nums|count }
    
    conditional {
      if ($len == 1) {
        var $result { value = 0 }
      }
      else {
        // Find max element and its index
        var $max_val { value = $input.nums[0] }
        var $max_idx { value = 0 }
        var $second_max { value = -1 }
        var $i { value = 1 }
        
        // Find max and track second max
        while ($i < $len) {
          each {
            var $current { value = $input.nums[$i] }
            
            conditional {
              if ($current > $max_val) {
                // Current becomes new max, old max becomes second max
                var $second_max { value = $max_val }
                var $max_val { value = $current }
                var $max_idx { value = $i }
              }
              elseif ($current > $second_max) {
                // Update second max
                var $second_max { value = $current }
              }
            }
            
            var.update $i { value = $i + 1 }
          }
        }
        
        // Check if max is at least twice the second max
        conditional {
          if ($max_val >= ($second_max * 2)) {
            var $result { value = $max_idx }
          }
          else {
            var $result { value = -1 }
          }
        }
      }
    }
  }
  
  response = $result
}
