function "find_anagram_mappings" {
  description = "Given two lists where one is an anagram of the other, find the index mapping from list1 to list2"
  
  input {
    int[] nums1 { description = "First list of integers" }
    int[] nums2 { description = "Second list (anagram of nums1)" }
  }
  
  stack {
    // Build a value-to-indices map for nums2
    // Since there could be duplicates, we store arrays of indices
    var $value_to_indices { value = {} }
    var $idx { value = 0 }
    
    foreach ($input.nums2) {
      each as $num {
        // Check if we already have this value in the map
        var $existing { value = $value_to_indices|get:($num|to_text):[] }
        var $updated { value = $existing|push:$idx }
        var $value_to_indices { value = $value_to_indices|set:($num|to_text):$updated }
        var $idx { value = $idx + 1 }
      }
    }
    
    // Build the result by finding each nums1 element in nums2
    var $result { value = [] }
    
    foreach ($input.nums1) {
      each as $num {
        // Get the indices list for this value
        var $indices { value = $value_to_indices|get:($num|to_text):[] }
        
        // Get the first available index
        var $first_idx { value = $indices|first }
        
        // Add to result
        var $result { value = $result|push:$first_idx }
        
        // Remove the used index (in case of duplicates)
        var $remaining { value = $indices|slice:1:(($indices|count) - 1) }
        var $value_to_indices { value = $value_to_indices|set:($num|to_text):$remaining }
      }
    }
  }
  
  response = $result
}
