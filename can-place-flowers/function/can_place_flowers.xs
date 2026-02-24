// Can Place Flowers - Array manipulation exercise
// You have a long flowerbed where some plots are planted (1) and some are empty (0).
// Flowers cannot be planted in adjacent plots.
// Given flowerbed array and n (number of flowers to plant), return true if all n flowers can be planted.
function "can_place_flowers" {
  description = "Determines if n flowers can be planted in flowerbed without adjacent flowers"
  
  input {
    int[] flowerbed { description = "Array where 0 = empty plot, 1 = planted plot" }
    int n { description = "Number of flowers to plant" }
  }
  
  stack {
    // Handle edge case: no flowers to plant
    conditional {
      if ($input.n == 0) {
        var $result { value = true }
      }
      else {
        // Count how many flowers we can plant
        var $can_plant { value = 0 }
        var $length { value = $input.flowerbed|count }
        var $i { value = 0 }
        
        while ($i < $length) {
          each {
            // Check if current plot is empty
            var $current_plot { value = $input.flowerbed[$i] }
            
            conditional {
              if ($current_plot == 0) {
                // Check left neighbor (i == 0 means no left neighbor, treat as empty)
                var $left_empty { value = false }
                conditional {
                  if ($i == 0) {
                    var $left_empty { value = true }
                  }
                  else {
                    var $left_val { value = $input.flowerbed[$i - 1] }
                    var $left_empty { value = ($left_val == 0) }
                  }
                }
                
                // Check right neighbor (i == length-1 means no right neighbor, treat as empty)
                var $right_empty { value = false }
                conditional {
                  if ($i == ($length - 1)) {
                    var $right_empty { value = true }
                  }
                  else {
                    var $right_val { value = $input.flowerbed[$i + 1] }
                    var $right_empty { value = ($right_val == 0) }
                  }
                }
                
                // If both neighbors are empty, plant a flower here
                conditional {
                  if ($left_empty && $right_empty) {
                    var $can_plant { value = $can_plant + 1 }
                    // Skip next plot since we planted here
                    var $i { value = $i + 1 }
                  }
                }
              }
            }
            
            var $i { value = $i + 1 }
          }
        }
        
        // Return true if we can plant at least n flowers
        var $result { value = ($can_plant >= $input.n) }
      }
    }
  }
  
  response = $result
}
