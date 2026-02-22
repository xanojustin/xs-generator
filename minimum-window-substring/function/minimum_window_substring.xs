// Minimum Window Substring - Classic sliding window coding exercise
// Given strings s and t, return the minimum window substring of s 
// such that every character in t (including duplicates) is included in the window.
// If no such substring exists, return empty string.
function "minimum_window_substring" {
  description = "Finds the minimum window substring containing all characters from t"
  
  input {
    text s { description = "Source string to search within" }
    text t { description = "Target string containing characters to find" }
  }
  
  stack {
    // Edge case: if t is empty or longer than s, return empty
    conditional {
      if (($input.t|strlen) == 0 || ($input.t|strlen) > ($input.s|strlen)) {
        var $result { value = "" }
      }
      else {
        // Build frequency map for characters in t
        var $target_freq { value = {} }
        foreach ($input.t|split:"") {
          each as $char {
            conditional {
              if ($target_freq|has:$char) {
                var $current_count { 
                  value = $target_freq|get:$char 
                }
                var $target_freq {
                  value = $target_freq|set:$char:($current_count + 1)
                }
              }
              else {
                var $target_freq {
                  value = $target_freq|set:$char:1
                }
              }
            }
          }
        }
        
        // Count of unique characters we need to match
        var $required { value = $target_freq|count }
        var $formed { value = 0 }
        
        // Window frequency map
        var $window_freq { value = {} }
        
        // Result tracking: min_length, start_idx
        var $min_length { value = ($input.s|strlen) + 1 }
        var $start_idx { value = 0 }
        
        // Sliding window pointers
        var $left { value = 0 }
        var $right { value = 0 }
        
        // Convert s to array for indexed access
        var $s_chars { value = $input.s|split:"" }
        var $s_len { value = $input.s|strlen }
        
        // Main sliding window loop
        while ($right < $s_len) {
          each {
            // Add character at right pointer to window
            var $right_char { 
              value = $s_chars[$right]
            }
            
            conditional {
              if ($window_freq|has:$right_char) {
                var $current_window {
                  value = $window_freq|get:$right_char
                }
                var $window_freq {
                  value = $window_freq|set:$right_char:($current_window + 1)
                }
              }
              else {
                var $window_freq {
                  value = $window_freq|set:$right_char:1
                }
              }
            }
            
            // Check if this character helps form the window
            conditional {
              if ($target_freq|has:$right_char) {
                var $target_count {
                  value = $target_freq|get:$right_char
                }
                var $window_count {
                  value = $window_freq|get:$right_char
                }
                conditional {
                  if ($window_count == $target_count) {
                    var $formed { value = $formed + 1 }
                  }
                }
              }
            }
            
            // Try to contract window from left while it's valid
            while ($formed == $required) {
              each {
                // Update minimum window if current is smaller
                var $window_size { 
                  value = $right - $left + 1
                }
                conditional {
                  if ($window_size < $min_length) {
                    var $min_length { value = $window_size }
                    var $start_idx { value = $left }
                  }
                }
                
                // Remove left character from window
                var $left_char {
                  value = $s_chars[$left]
                }
                var $left_count {
                  value = $window_freq|get:$left_char
                }
                var $window_freq {
                  value = $window_freq|set:$left_char:($left_count - 1)
                }
                
                // Check if removing this character breaks the window
                conditional {
                  if ($target_freq|has:$left_char) {
                    var $target_left {
                      value = $target_freq|get:$left_char
                    }
                    var $new_window_left {
                      value = $window_freq|get:$left_char
                    }
                    conditional {
                      if ($new_window_left < $target_left) {
                        var $formed { value = $formed - 1 }
                      }
                    }
                  }
                }
                
                var.update $left { value = $left + 1 }
              }
            }
            
            var.update $right { value = $right + 1 }
          }
        }
        
        // Build result string
        conditional {
          if ($min_length <= $input.s|strlen) {
            // Extract substring from start_idx with length min_length
            var $result_chars { value = [] }
            var $i { value = $start_idx }
            while ($i < $start_idx + $min_length) {
              each {
                var $char_val {
                  value = $s_chars[$i]
                }
                var $result_chars {
                  value = $result_chars|push:$char_val
                }
                var.update $i { value = $i + 1 }
              }
            }
            var $result {
              value = $result_chars|join:""
            }
          }
          else {
            var $result { value = "" }
          }
        }
      }
    }
  }
  
  response = $result
}
