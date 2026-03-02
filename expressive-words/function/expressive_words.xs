function "expressive_words" {
  description = "Count how many words are 'stretchy' versions of the target word"
  input {
    text target { description = "The original target word (e.g., 'heeellooo')" }
    text[] words { description = "Array of query words to check" }
  }
  stack {
    // Helper: Parse a word into groups of (char, count)
    var $target_groups { value = [] }
    var $i { value = 0 }
    
    while ($i < ($target|strlen)) {
      each {
        var $char { value = $target|substr:$i:1 }
        var $count { value = 1 }
        var $j { value = $i + 1 }
        
        while ($j < ($target|strlen)) {
          each {
            var $next_char { value = $target|substr:$j:1 }
            conditional {
              if ($next_char == $char) {
                var.update $count { value = $count + 1 }
                var.update $j { value = $j + 1 }
              }
              else {
                return { value = null }
              }
            }
          }
        }
        
        var $new_group { value = { char: $char, count: $count } }
        var.update $target_groups { value = $target_groups|merge:[$new_group] }
        var.update $i { value = $j }
      }
    }
    
    // Count stretchy words
    var $stretchy_count { value = 0 }
    
    foreach ($words) {
      each as $word {
        var $word_groups { value = [] }
        var $wi { value = 0 }
        
        // Parse word into groups
        while ($wi < ($word|strlen)) {
          each {
            var $w_char { value = $word|substr:$wi:1 }
            var $w_count { value = 1 }
            var $wj { value = $wi + 1 }
            
            while ($wj < ($word|strlen)) {
              each {
                var $w_next_char { value = $word|substr:$wj:1 }
                conditional {
                  if ($w_next_char == $w_char) {
                    var.update $w_count { value = $w_count + 1 }
                    var.update $wj { value = $wj + 1 }
                  }
                  else {
                    return { value = null }
                  }
                }
              }
            }
            
            var $w_new_group { value = { char: $w_char, count: $w_count } }
            var.update $word_groups { value = $word_groups|merge:[$w_new_group] }
            var.update $wi { value = $wj }
          }
        }
        
        // Check if groups match in structure
        var $is_stretchy { value = true }
        
        conditional {
          if (($word_groups|count) != ($target_groups|count)) {
            var.update $is_stretchy { value = false }
          }
        }
        
        conditional {
          if ($is_stretchy == true) {
            var $gi { value = 0 }
            while ($gi < ($target_groups|count)) {
              each {
                var $tg { value = $target_groups|get:$gi }
                var $wg { value = $word_groups|get:$gi }
                
                // Check character matches
                conditional {
                  if (($tg|get:"char") != ($wg|get:"char")) {
                    var.update $is_stretchy { value = false }
                  }
                }
                
                // Check count is valid
                conditional {
                  if ($is_stretchy == true) {
                    var $t_count { value = $tg|get:"count" }
                    var $w_count_val { value = $wg|get:"count" }
                    
                    // Word count must be <= target count
                    conditional {
                      if ($w_count_val > $t_count) {
                        var.update $is_stretchy { value = false }
                      }
                    }
                    
                    // If target has stretch (>=3), word can be anything <= target
                    // If target has no stretch (<3), word must match exactly
                    conditional {
                      if (($is_stretchy == true) && ($t_count < 3) && ($w_count_val != $t_count)) {
                        var.update $is_stretchy { value = false }
                      }
                    }
                  }
                }
                
                var.update $gi { value = $gi + 1 }
              }
            }
          }
        }
        
        conditional {
          if ($is_stretchy == true) {
            var.update $stretchy_count { value = $stretchy_count + 1 }
          }
        }
      }
    }
  }
  response = $stretchy_count
}
