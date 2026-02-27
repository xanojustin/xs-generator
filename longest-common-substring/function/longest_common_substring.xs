function "longest_common_substring" {
  description = "Find the length of the longest common substring between two strings"
  input {
    text str1 filters=trim
    text str2 filters=trim
  }
  stack {
    // Get lengths of both strings
    var $len1 { value = $input.str1|strlen }
    var $len2 { value = $input.str2|strlen }
    
    // Edge case: if either string is empty, return 0
    conditional {
      if ($len1 == 0 || $len2 == 0) {
        var $max_length { value = 0 }
      }
      else {
        // Initialize variables for the dynamic programming approach
        // We only need to track the previous row for space efficiency
        var $max_length { value = 0 }
        var $prev_row { value = [] }
        var $curr_row { value = [] }
        
        // Initialize previous row with zeros
        for ($len2 + 1) {
          each as $i {
            var.update $prev_row { value = $prev_row|push:0 }
          }
        }
        
        // Iterate through each character of str1
        var $i { value = 1 }
        while ($i <= $len1) {
          each {
            // Initialize current row
            var.update $curr_row { value = [0] }
            
            // Get current character from str1
            var $char1 { value = $input.str1|substr:($i - 1):1 }
            
            // Iterate through each character of str2
            var $j { value = 1 }
            while ($j <= $len2) {
              each {
                // Get current character from str2
                var $char2 { value = $input.str2|substr:($j - 1):1 }
                
                conditional {
                  if ($char1 == $char2) {
                    // Characters match - extend the substring
                    var $prev_val { value = $prev_row|get:($j - 1) }
                    var $new_val { value = $prev_val + 1 }
                    var.update $curr_row { value = $curr_row|push:$new_val }
                    
                    // Update max length if needed
                    conditional {
                      if ($new_val > $max_length) {
                        var.update $max_length { value = $new_val }
                      }
                    }
                  }
                  else {
                    // Characters don't match - reset to 0
                    var.update $curr_row { value = $curr_row|push:0 }
                  }
                }
                
                var.update $j { value = $j + 1 }
              }
            }
            
            // Swap rows for next iteration
            var.update $prev_row { value = $curr_row }
            var.update $curr_row { value = [] }
            
            var.update $i { value = $i + 1 }
          }
        }
      }
    }
  }
  response = $max_length
}
