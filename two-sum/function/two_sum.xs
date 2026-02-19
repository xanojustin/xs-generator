// Two Sum - Classic coding exercise
// Given an array of integers and a target, return indices of two numbers that add up to target
// Uses a hash map approach for O(n) time complexity
function "two_sum" {
  description = "Finds indices of two numbers that add up to target"
  
  input {
    int[] nums { description = "Array of integers to search" }
    int target { description = "Target sum value" }
  }
  
  stack {
    // Hash map to store seen numbers and their indices
    var $seen { value = {} }
    var $result { value = [] }
    var $found { value = false }
    
    // Use manual index counter since foreach with index has syntax issues
    var $index { value = 0 }
    
    foreach ($input.nums) {
      each as $num {
        conditional {
          // Calculate complement needed to reach target
          if (!$found) {
            var $complement { value = $input.target - $num }
            
            // Check if complement exists in seen map
            conditional {
              if ($seen|has:($complement|to_text)) {
                // Found the pair - get complement index and current index
                var $complement_index { 
                  value = $seen|get:($complement|to_text)
                }
                var $result {
                  value = [$complement_index, $index]
                }
                var $found { value = true }
              }
              else {
                // Store current number and its index using set filter
                var $seen {
                  value = $seen|set:($num|to_text):$index
                }
              }
            }
          }
        }
        
        var.update $index { value = $index + 1 }
      }
    }
  }
  
  response = $result
}
