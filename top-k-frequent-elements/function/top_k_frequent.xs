function "top_k_frequent" {
  description = "Find the k most frequent elements in an array"
  input {
    int[] nums
    int k
  }
  stack {
    // Build frequency map using object
    var $freq_map { value = {} }
    
    foreach ($input.nums) {
      each as $num {
        var $key { value = $num|to_text }
        // Check if key exists in frequency map
        conditional {
          if ($freq_map|has:$key) {
            // Increment existing count
            var $current { value = $freq_map|get:$key:0 }
            var $updated { value = $current + 1 }
            var.update $freq_map { value = $freq_map|set:$key:$updated }
          }
          else {
            // Initialize count to 1
            var.update $freq_map { value = $freq_map|set:$key:1 }
          }
        }
      }
    }
    
    // Convert frequency map to array of objects for sorting
    var $freq_list { value = [] }
    object.keys { value = $freq_map } as $keys
    
    foreach ($keys) {
      each as $key {
        var $count { value = $freq_map|get:$key:0 }
        var $num_val { value = $key|to_int }
        var $entry { value = {num: $num_val, count: $count} }
        array.push $freq_list { value = $entry }
      }
    }
    
    // Sort by frequency descending using bubble sort
    var $sorted { value = $freq_list }
    var $n { value = $freq_list|count }
    var $i { value = 0 }
    
    while ($i < $n) {
      each {
        var $j { value = 0 }
        while ($j < ($n - $i - 1)) {
          each {
            var $left_idx { value = $j }
            var $right_idx { value = $j + 1 }
            var $left { value = $sorted|get:$left_idx:{count: 0} }
            var $right { value = $sorted|get:$right_idx:{count: 0} }
            
            conditional {
              if ($left.count < $right.count) {
                // Swap elements
                var $temp { value = $left }
                var $sorted { value = $sorted|set:$left_idx:$right }
                var $sorted { value = $sorted|set:$right_idx:$temp }
              }
            }
            
            var.update $j { value = $j + 1 }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Extract top k elements
    var $result { value = [] }
    var $idx { value = 0 }
    while ($idx < $input.k && $idx < $n) {
      each {
        var $item { value = $sorted|get:$idx:{num: 0} }
        array.push $result { value = $item.num }
        var.update $idx { value = $idx + 1 }
      }
    }
  }
  response = $result
}
