function "next_permutation" {
  description = "Rearranges numbers into the lexicographically next greater permutation"
  input {
    int[] nums { description = "Array of integers to find next permutation for" }
  }
  stack {
    // Copy the input array to avoid mutating the original
    var $arr { value = $input.nums }
    var $n { value = ($arr|count) }
    
    // Edge case: empty array or single element - return as-is
    var $result { value = $arr }
    
    conditional {
      if ($n > 1) {
        // Step 1: Find the first decreasing element from the right
        // We need to find the largest index i such that arr[i] < arr[i + 1]
        var $i { value = $n - 2 }
        
        while ($i >= 0 && ($arr|get:$i) >= ($arr|get:($i + 1))) {
          each {
            var $new_i { value = $i - 1 }
            var.update $i { value = $new_i }
          }
        }
        
        // Step 2: If we found such an index, find the element to swap with
        conditional {
          if ($i >= 0) {
            // Find the largest index j such that arr[j] > arr[i]
            var $j { value = $n - 1 }
            
            while ($j >= 0 && ($arr|get:$j) <= ($arr|get:$i)) {
              each {
                var $new_j { value = $j - 1 }
                var.update $j { value = $new_j }
              }
            }
            
            // Step 3: Swap arr[i] and arr[j]
            var $temp_i { value = $arr|get:$i }
            var $temp_j { value = $arr|get:$j }
            
            // Create new array with swapped elements
            var $before_i { value = ($i > 0) ? ($arr|slice:0:$i) : [] }
            var $after_j { value = ($j < $n - 1) ? ($arr|slice:($j + 1):($n - $j - 1)) : [] }
            var $between { value = (($j - $i) > 1) ? ($arr|slice:($i + 1):($j - $i - 1)) : [] }
            
            // Rebuild the array: before_i + [temp_j] + between + [temp_i] + after_j
            var $new_arr { value = $before_i|merge:[$temp_j] }
            var.update $new_arr { value = $new_arr|merge:$between }
            var.update $new_arr { value = $new_arr|merge:[$temp_i] }
            var.update $new_arr { value = $new_arr|merge:$after_j }
            
            var.update $arr { value = $new_arr }
          }
        }
        
        // Step 4: Reverse the elements after index i
        // Get the prefix (up to and including i) and suffix (after i)
        var $prefix_end { value = $i + 1 }
        var $prefix { value = ($prefix_end > 0) ? ($arr|slice:0:$prefix_end) : [] }
        var $suffix { value = ($prefix_end < $n) ? ($arr|slice:$prefix_end:($n - $prefix_end)) : [] }
        
        // Reverse the suffix
        var $reversed_suffix { value = $suffix|reverse }
        
        // Combine prefix and reversed suffix
        var.update $result { value = $prefix|merge:$reversed_suffix }
      }
    }
  }
  response = $result
}
