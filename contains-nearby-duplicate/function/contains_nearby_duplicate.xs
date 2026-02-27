function "contains_nearby_duplicate" {
  description = "Check if there are two distinct indices i and j such that nums[i] == nums[j] and abs(i - j) <= k"
  input {
    int[] nums
    int k
  }
  stack {
    // Use an object as a hash map to store the most recent index of each number
    var $index_map { value = {} }
    var $result { value = false }
    var $i { value = 0 }
    
    // Iterate through the array
    foreach ($input.nums) {
      each as $num {
        // Check if we've seen this number before
        var $num_key { value = $num|to_text }
        var $has_key { value = $index_map|has:$num_key }
        
        conditional {
          if ($has_key) {
            // Get the previous index
            var $prev_index { value = $index_map|get:$num_key }
            var $diff { value = $i - $prev_index }
            
            conditional {
              if ($diff <= $input.k) {
                var $result { value = true }
                // Early return - we found a match
                return { value = true }
              }
            }
          }
        }
        
        // Update the index map with current position
        var $index_map { value = $index_map|set:$num_key:$i }
        
        // Increment index counter
        var $i { value = $i + 1 }
      }
    }
  }
  response = $result
}
