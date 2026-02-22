// Longest Consecutive Sequence
// Finds the length of the longest consecutive elements sequence
// Uses hash set for O(n) time complexity
function "longest_consecutive_sequence" {
  description = "Finds the length of the longest consecutive elements sequence in an array"
  
  input {
    int[] nums { description = "Array of integers (may contain duplicates and negative numbers)" }
  }
  
  stack {
    // Handle edge case: empty array
    conditional {
      if (($input.nums|count) == 0) {
        return { value = 0 }
      }
    }
    
    // Create a set (object with keys as set members) for O(1) lookups
    var $num_set { value = {} }
    foreach ($input.nums) {
      each as $num {
        var $num_set { value = $num_set|set:($num|to_text):true }
      }
    }
    
    var $max_length { value = 0 }
    
    // Iterate through each number in the set
    foreach ($input.nums) {
      each as $num {
        // Only start counting if this is the beginning of a sequence
        // (i.e., num - 1 is not in the set)
        var $prev_num { value = $num - 1 }
        var $prev_key { value = $prev_num|to_text }
        
        conditional {
          if (!($num_set|get:$prev_key:false)) {
            // This is the start of a sequence, count consecutive numbers
            var $current_num { value = $num }
            var $current_length { value = 1 }
            
            // Keep checking for consecutive numbers
            var $continue_search { value = true }
            while ($continue_search) {
              each {
                var $next_num { value = $current_num + 1 }
                var $next_key { value = $next_num|to_text }
                
                conditional {
                  if ($num_set|get:$next_key:false) {
                    var $current_num { value = $next_num }
                    var $current_length { value = $current_length + 1 }
                  }
                  else {
                    var $continue_search { value = false }
                  }
                }
              }
            }
            
            // Update max length if this sequence is longer
            conditional {
              if ($current_length > $max_length) {
                var $max_length { value = $current_length }
              }
            }
          }
        }
      }
    }
  }
  
  response = $max_length
}
