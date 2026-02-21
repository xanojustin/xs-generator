// Longest Substring Without Repeating Characters
// Given a string, find the length of the longest substring without repeating characters
function "longest_substring" {
  description = "Finds the length of the longest substring without repeating characters"
  
  input {
    text text { description = "The input string to analyze" }
  }
  
  stack {
    // Handle edge case of empty string
    conditional {
      if ($input.text == "") {
        return { value = 0 }
      }
    }
    
    // Convert string to array of characters
    var $chars { value = $input.text|split:"" }
    
    // Variables for sliding window
    var $left { value = 0 }
    var $max_length { value = 0 }
    var $char_index_map { value = {} }
    var $right { value = 0 }
    
    while ($right < ($chars|count)) {
      each {
        var $current_char { value = $chars[$right] }
        var $char_position { value = $char_index_map|get:($current_char):-1 }
        
        conditional {
          // If char seen and is within current window, move left pointer
          if ($char_position >= $left) {
            var.update $left { value = $char_position + 1 }
          }
        }
        
        // Update char position
        var $char_index_map {
          value = $char_index_map|set:($current_char):($right)
        }
        
        // Calculate current window size
        var $current_window { value = $right - $left + 1 }
        
        conditional {
          if ($current_window > $max_length) {
            var.update $max_length { value = $current_window }
          }
        }
        
        var.update $right { value = $right + 1 }
      }
    }
  }
  
  response = $max_length
}
