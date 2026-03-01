// Longest Substring with At Most Two Distinct Characters
// Given a string, find the length of the longest substring that contains at most 2 distinct characters.
// Uses the sliding window technique.
function "longest_substring_two_distinct" {
  description = "Finds the length of the longest substring with at most 2 distinct characters"
  
  input {
    text s { description = "The input string to analyze" }
  }
  
  stack {
    // Edge case: empty string
    conditional {
      if (($input.s|strlen) == 0) {
        return { value = 0 }
      }
    }
    
    // Initialize sliding window variables
    var $left { value = 0 }
    var $right { value = 0 }
    var $max_length { value = 0 }
    var $char_count { value = {} }
    var $distinct_count { value = 0 }
    var $string_length { value = $input.s|strlen }
    
    // Convert string to array of characters for indexing
    var $chars { value = $input.s|split:"" }
    
    // Sliding window: expand right pointer
    while ($right < $string_length) {
      each {
        // Get current character at right pointer
        var $current_char { 
          value = $chars[$right] 
        }
        
        // Get current count for this character (default to 0)
        var $current_count { 
          value = ($char_count|get:($current_char|to_text):0)|to_int 
        }
        
        // If this is a new character in the window, increment distinct count
        conditional {
          if ($current_count == 0) {
            var.update $distinct_count { value = $distinct_count + 1 }
          }
        }
        
        // Increment count for this character
        var $new_count { value = $current_count + 1 }
        var.update $char_count { 
          value = $char_count|set:($current_char|to_text):($new_count|to_text)
        }
        
        // Shrink window from left while we have more than 2 distinct characters
        while ($distinct_count > 2) {
          each {
            // Get character at left pointer
            var $left_char { 
              value = $chars[$left] 
            }
            
            // Get count for left character
            var $left_count { 
              value = ($char_count|get:($left_char|to_text):0)|to_int 
            }
            
            // Decrement count
            var $new_left_count { value = $left_count - 1 }
            var.update $char_count { 
              value = $char_count|set:($left_char|to_text):($new_left_count|to_text)
            }
            
            // If count reaches 0, decrement distinct count
            conditional {
              if ($new_left_count == 0) {
                var.update $distinct_count { value = $distinct_count - 1 }
              }
            }
            
            // Move left pointer forward
            var.update $left { value = $left + 1 }
          }
        }
        
        // Update max length if current window is larger
        var $window_size { value = $right - $left + 1 }
        conditional {
          if ($window_size > $max_length) {
            var.update $max_length { value = $window_size }
          }
        }
        
        // Move right pointer forward
        var.update $right { value = $right + 1 }
      }
    }
  }
  
  response = $max_length
}
