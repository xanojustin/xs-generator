// Wiggle Sort - Arrange array so that nums[0] <= nums[1] >= nums[2] <= nums[3]...
// This creates a "wiggle" pattern where every odd-indexed element is a peak
function "wiggle_sort" {
  description = "Rearranges array into wiggle pattern: nums[0] <= nums[1] >= nums[2] <= nums[3]..."
  
  input {
    int[] nums { description = "Input array of integers to wiggle sort" }
  }
  
  stack {
    // Handle edge cases
    conditional {
      if (($input.nums|count) <= 1) {
        var $result { value = $input.nums }
      }
      else {
        // Make a copy of the input array to work with
        var $arr { value = $input.nums }
        
        // Iterate through array starting from index 1
        var $i { value = 1 }
        
        while ($i < ($arr|count)) {
          each {
            // Get current and previous elements
            var $curr { value = $arr[$i] }
            var $prev { value = $arr[$i - 1] }
            
            // For odd indices (1, 3, 5...), ensure current >= previous
            // For even indices (2, 4, 6...), ensure current <= previous
            conditional {
              if ($i % 2 == 1) {
                // Odd index: should be >= previous
                conditional {
                  if ($curr < $prev) {
                    // Swap to ensure wiggle property
                    var $temp { value = $prev }
                    var.update $arr[$i - 1] { value = $curr }
                    var.update $arr[$i] { value = $temp }
                  }
                }
              }
              else {
                // Even index: should be <= previous
                conditional {
                  if ($curr > $prev) {
                    // Swap to ensure wiggle property
                    var $temp { value = $prev }
                    var.update $arr[$i - 1] { value = $curr }
                    var.update $arr[$i] { value = $temp }
                  }
                }
              }
            }
            
            var.update $i { value = $i + 1 }
          }
        }
        
        var $result { value = $arr }
      }
    }
  }
  
  response = $result
}
