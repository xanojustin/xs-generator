// Longest Harmonious Subsequence - Classic coding exercise
// Given an integer array, find the length of the longest harmonious subsequence
// A harmonious subsequence is one where max - min = 1
// Example: [1,3,2,2,5,2,3,7] → [3,2,2,2,3] has length 5 (max=3, min=2)
function "longest_harmonious_subsequence" {
  description = "Finds the length of the longest harmonious subsequence"
  
  input {
    int[] nums { description = "Array of integers" }
  }
  
  stack {
    // Frequency map to count occurrences of each number
    var $frequency { value = {} }
    var $max_length { value = 0 }
    
    // Build frequency map
    foreach ($input.nums) {
      each as $num {
        conditional {
          if ($frequency|has:($num|to_text)) {
            // Increment existing count
            var $current_count {
              value = $frequency|get:($num|to_text)
            }
            var $frequency {
              value = $frequency|set:($num|to_text):($current_count + 1)
            }
          }
          else {
            // Initialize count to 1
            var $frequency {
              value = $frequency|set:($num|to_text):1
            }
          }
        }
      }
    }
    
    // Find longest harmonious subsequence
    // For each number, check if number+1 exists
    foreach ($input.nums) {
      each as $num {
        var $num_plus_one { value = $num + 1 }
        
        conditional {
          if ($frequency|has:($num_plus_one|to_text)) {
            // Calculate length of harmonious subsequence
            var $count_num {
              value = $frequency|get:($num|to_text)
            }
            var $count_num_plus_one {
              value = $frequency|get:($num_plus_one|to_text)
            }
            var $current_length {
              value = $count_num + $count_num_plus_one
            }
            
            // Update max length if this is longer
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