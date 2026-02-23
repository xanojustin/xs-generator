function "count_k_diff_pairs" {
  description = "Count the number of unique k-diff pairs in an array"
  input {
    int[] nums
    int k
  }
  stack {
    // Handle edge case: k < 0 means no valid pairs possible
    conditional {
      if (`$input.k < 0`) {
        var $result { value = 0 }
      }
      else {
        // Use a frequency map to count occurrences
        var $freq_map { value = {} }
        
        // Build frequency map by iterating through nums
        var $i { value = 0 }
        while ($i < ($input.nums|count)) {
          each {
            var $num { value = $input.nums[$i] }
            var $current_count { value = $freq_map|get:($num|to_text):0 }
            var $new_count { value = $current_count + 1 }
            var $freq_map { value = $freq_map|set:($num|to_text):$new_count }
            var $i { value = $i + 1 }
          }
        }
        
        var $unique_count { value = 0 }
        
        // For k = 0, count numbers that appear more than once
        conditional {
          if (`$input.k == 0`) {
            // Iterate through frequency map entries
            var $keys { value = $freq_map|keys }
            var $j { value = 0 }
            while ($j < ($keys|count)) {
              each {
                var $key { value = $keys[$j] }
                var $count { value = $freq_map|get:$key }
                conditional {
                  if (`$count > 1`) {
                    var $unique_count { value = $unique_count + 1 }
                  }
                }
                var $j { value = $j + 1 }
              }
            }
          }
          else {
            // For k > 0, check if num + k exists in the map
            var $keys { value = $freq_map|keys }
            var $j { value = 0 }
            while ($j < ($keys|count)) {
              each {
                var $key { value = $keys[$j] }
                var $num { value = $key|to_int }
                var $target { value = ($num + $input.k)|to_text }
                var $exists { value = $freq_map|has:$target }
                conditional {
                  if (`$exists`) {
                    var $unique_count { value = $unique_count + 1 }
                  }
                }
                var $j { value = $j + 1 }
              }
            }
          }
        }
        
        var $result { value = $unique_count }
      }
    }
  }
  response = $result
}
