function "find_all_anagrams" {
  description = "Find all start indices of anagrams of pattern p in string s"
  
  input {
    text s { description = "The string to search within" }
    text p { description = "The pattern to find anagrams of" }
  }
  
  stack {
    // Edge case: if pattern is longer than string, no anagrams possible
    var $s_len { value = $input.s|strlen }
    var $p_len { value = $input.p|strlen }
    var $result { value = [] }
    
    conditional {
      if ($p_len > $s_len) {
        return { value = $result }
      }
    }
    
    // Convert strings to character arrays
    var $s_chars { value = $input.s|split:"" }
    var $p_chars { value = $input.p|split:"" }
    
    // Initialize frequency maps using characters as keys
    var $pattern_freq { value = {} }
    var $window_freq { value = {} }
    
    // Build pattern frequency map
    var $i { value = 0 }
    while ($i < $p_len) {
      each {
        var $char { value = $p_chars|get:$i }
        
        conditional {
          if ($pattern_freq|has:$char) {
            var $current_count { value = $pattern_freq|get:$char }
            var $pattern_freq {
              value = $pattern_freq|set:$char:($current_count + 1)
            }
          }
          else {
            var $pattern_freq {
              value = $pattern_freq|set:$char:1
            }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
    
    // Initialize first window
    var $i { value = 0 }
    while ($i < $p_len) {
      each {
        var $char { value = $s_chars|get:$i }
        
        conditional {
          if ($window_freq|has:$char) {
            var $current_count { value = $window_freq|get:$char }
            var $window_freq {
              value = $window_freq|set:$char:($current_count + 1)
            }
          }
          else {
            var $window_freq {
              value = $window_freq|set:$char:1
            }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
    
    // Helper to compare two frequency maps
    var $matches { value = true }
    
    // Check pattern keys exist in window with same count
    var $p_keys { value = $pattern_freq|keys }
    foreach ($p_keys) {
      each as $key {
        conditional {
          if ($matches) {
            var $p_count { value = $pattern_freq|get:$key }
            var $w_count { value = 0 }
            
            conditional {
              if ($window_freq|has:$key) {
                var $w_count { value = $window_freq|get:$key }
              }
            }
            
            conditional {
              if ($p_count != $w_count) {
                var $matches { value = false }
              }
            }
          }
        }
      }
    }
    
    // Check window doesn't have extra keys
    var $w_keys { value = $window_freq|keys }
    foreach ($w_keys) {
      each as $key {
        conditional {
          if ($matches) {
            conditional {
              if (!$pattern_freq|has:$key) {
                var $matches { value = false }
              }
            }
          }
        }
      }
    }
    
    conditional {
      if ($matches) {
        var $result {
          value = $result|push:0
        }
      }
    }
    
    // Slide the window
    var $left { value = 0 }
    var $right { value = $p_len }
    
    while ($right < $s_len) {
      each {
        // Get the characters for this iteration
        var $left_char { value = $s_chars|get:$left }
        var $right_char { value = $s_chars|get:$right }
        
        // Remove leftmost char from window (decrement count)
        conditional {
          if ($window_freq|has:$left_char) {
            var $left_count { value = $window_freq|get:$left_char }
            conditional {
              if ($left_count <= 1) {
                // Remove key by setting to 0 (effectively removing)
                var $window_freq {
                  value = $window_freq|set:$left_char:0
                }
              }
              else {
                var $window_freq {
                  value = $window_freq|set:$left_char:($left_count - 1)
                }
              }
            }
          }
        }
        
        // Add new char at right
        conditional {
          if ($window_freq|has:$right_char) {
            var $current_count { value = $window_freq|get:$right_char }
            var $window_freq {
              value = $window_freq|set:$right_char:($current_count + 1)
            }
          }
          else {
            var $window_freq {
              value = $window_freq|set:$right_char:1
            }
          }
        }
        
        // Check if current window matches pattern
        var $matches { value = true }
        
        // Check pattern keys
        var $p_keys { value = $pattern_freq|keys }
        foreach ($p_keys) {
          each as $key {
            conditional {
              if ($matches) {
                var $p_count { value = $pattern_freq|get:$key }
                var $w_count { value = 0 }
                
                conditional {
                  if ($window_freq|has:$key) {
                    var $w_count { value = $window_freq|get:$key }
                  }
                }
                
                conditional {
                  if ($p_count != $w_count) {
                    var $matches { value = false }
                  }
                }
              }
            }
          }
        }
        
        // Check for extra keys in window
        var $w_keys { value = $window_freq|keys }
        foreach ($w_keys) {
          each as $key {
            conditional {
              if ($matches) {
                conditional {
                  if (!$pattern_freq|has:$key) {
                    var $matches { value = false }
                  }
                }
              }
            }
          }
        }
        
        conditional {
          if ($matches) {
            var $result {
              value = $result|push:($left + 1)
            }
          }
        }
        
        var.update $left { value = $left + 1 }
        var.update $right { value = $right + 1 }
      }
    }
  }
  
  response = $result
}
