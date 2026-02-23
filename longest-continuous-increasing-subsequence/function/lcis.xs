function "lcis" {
  description = "Find the length of the longest continuous increasing subsequence"
  input {
    int[] nums
  }
  stack {
    // Edge case: empty array
    conditional {
      if (($input.nums|count) == 0) {
        var $result { value = 0 }
      }
      else {
        // Edge case: single element
        conditional {
          if (($input.nums|count) == 1) {
            var $result { value = 1 }
          }
          else {
            // Track current streak and max streak
            var $max_length { value = 1 }
            var $current_length { value = 1 }
            
            // Iterate from second element to end
            var $i { value = 1 }
            while ($i < ($input.nums|count)) {
              each {
                // Get current and previous elements
                var $prev { value = $input.nums|slice:($i - 1):$i|first }
                var $curr { value = $input.nums|slice:$i:($i + 1)|first }
                
                conditional {
                  if ($curr > $prev) {
                    // Increasing - extend current streak
                    math.add $current_length { value = 1 }
                  }
                  else {
                    // Not increasing - reset current streak
                    var.update $current_length { value = 1 }
                  }
                }
                
                // Update max if current is longer
                conditional {
                  if ($current_length > $max_length) {
                    var.update $max_length { value = $current_length }
                  }
                }
                
                // Move to next element
                math.add $i { value = 1 }
              }
            }
            
            var $result { value = $max_length }
          }
        }
      }
    }
  }
  response = $result
}
