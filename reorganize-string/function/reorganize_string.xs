// Reorganize String - Greedy algorithm exercise
// Rearranges characters so no two adjacent characters are the same
function "reorganize_string" {
  description = "Rearranges string so no two adjacent characters are the same"
  
  input {
    text s { description = "Input string to reorganize" }
  }
  
  stack {
    // Handle edge cases - store length in variable first
    var $len { value = $input.s|strlen }
    
    conditional {
      if ($len <= 1) {
        var $result_str { value = $input.s }
      }
      else {
        // Count character frequencies using a simple approach
        var $freq { value = [] }
        var $chars { value = $input.s|split:"" }
        var $i { value = 0 }
        
        while ($i < $len) {
          each {
            var $char { value = $chars[$i] }
            var $found_index { value = -1 }
            var $j { value = 0 }
            
            // Check if char already in freq list
            while ($j < ($freq|count)) {
              each {
                conditional {
                  if ($freq[$j].char == $char) {
                    var $found_index { value = $j }
                  }
                }
                var $j { value = $j + 1 }
              }
            }
            
            // Update or add to freq
            conditional {
              if ($found_index >= 0) {
                var $new_count { value = $freq[$found_index].count + 1 }
                var $new_entry { value = {char: $char, count: $new_count} }
                var $freq_before { value = $freq|slice:0:$found_index }
                var $freq_after { value = $freq|slice:($found_index + 1) }
                var $freq { value = $freq_before|merge:[$new_entry]|merge:$freq_after }
              }
              else {
                var $new_entry { value = {char: $char, count: 1} }
                var $freq { value = $freq|merge:[$new_entry] }
              }
            }
            
            var $i { value = $i + 1 }
          }
        }
        
        // Find max frequency
        var $max_freq { value = 0 }
        var $k { value = 0 }
        while ($k < ($freq|count)) {
          each {
            conditional {
              if ($freq[$k].count > $max_freq) {
                var $max_freq { value = $freq[$k].count }
              }
            }
            var $k { value = $k + 1 }
          }
        }
        
        // Check if reorganization is possible
        // If max frequency > (length + 1) / 2, impossible
        var $threshold { value = ($len + 1) / 2 }
        conditional {
          if ($max_freq > $threshold) {
            var $result_str { value = "" }
          }
          else {
            // Sort by frequency descending using bubble sort
            var $sorted_freq { value = $freq }
            var $n { value = $sorted_freq|count }
            var $a { value = 0 }
            while ($a < ($n - 1)) {
              each {
                var $b { value = 0 }
                while ($b < (($n - $a) - 1)) {
                  each {
                    conditional {
                      if ($sorted_freq[$b].count < $sorted_freq[($b + 1)].count) {
                        // Swap
                        var $temp { value = $sorted_freq[$b] }
                        var $sorted_freq_before { value = $sorted_freq|slice:0:$b }
                        var $sorted_freq_after { value = $sorted_freq|slice:($b + 1) }
                        var $sorted_freq_mid { value = $sorted_freq_before|merge:[$sorted_freq[($b + 1)]] }
                        var $sorted_freq { value = $sorted_freq_mid|merge:[$temp]|merge:$sorted_freq_after }
                      }
                    }
                    var $b { value = $b + 1 }
                  }
                }
                var $a { value = $a + 1 }
              }
            }
            
            // Build result using greedy approach
            // Place most frequent chars at even indices, then odd indices
            var $result { value = [] }
            var $idx { value = 0 }
            
            // Initialize result array with placeholders
            while ($idx < $len) {
              each {
                var $result { value = $result|merge:[""] }
                var $idx { value = $idx + 1 }
              }
            }
            
            // Place characters - even positions first
            var $result_idx { value = 0 }
            var $char_idx { value = 0 }
            while ($char_idx < $n) {
              each {
                var $entry { value = $sorted_freq[$char_idx] }
                var $count { value = $entry.count }
                var $ch { value = $entry.char }
                
                while ($count > 0) {
                  each {
                    // Place at current position
                    var $result_before { value = $result|slice:0:$result_idx }
                    var $result_after { value = $result|slice:($result_idx + 1) }
                    var $result { value = $result_before|merge:[$ch]|merge:$result_after }
                    
                    var $count { value = $count - 1 }
                    var $result_idx { value = $result_idx + 2 }
                    
                    // If we go past end, start at index 1
                    conditional {
                      if ($result_idx >= $len) {
                        var $result_idx { value = 1 }
                      }
                    }
                  }
                }
                
                var $char_idx { value = $char_idx + 1 }
              }
            }
            
            // Join result into string
            var $final_result { value = "" }
            var $m { value = 0 }
            while ($m < $len) {
              each {
                var $final_result { value = $final_result ~ $result[$m] }
                var $m { value = $m + 1 }
              }
            }
            var $result_str { value = $final_result }
          }
        }
      }
    }
  }
  
  response = $result_str
}
