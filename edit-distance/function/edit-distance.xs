// Edit Distance (Levenshtein Distance) - Dynamic Programming Solution
// Calculates the minimum number of operations (insert, delete, replace)
// required to transform one string into another
function "edit-distance" {
  description = "Calculate minimum edit distance between two strings"
  
  input {
    text str1 { description = "First string" }
    text str2 { description = "Second string" }
  }
  
  stack {
    // Get lengths of both strings
    var $len1 { value = $input.str1|strlen }
    var $len2 { value = $input.str2|strlen }
    
    // Handle edge cases
    conditional {
      if ($len1 == 0) {
        return { value = $len2 }
      }
    }
    
    conditional {
      if ($len2 == 0) {
        return { value = $len1 }
      }
    }
    
    // Create DP matrix as an array of arrays
    // dp[i][j] = edit distance between str1[0..i-1] and str2[0..j-1]
    var $dp { value = [] }
    
    // Initialize the DP matrix
    var $i { value = 0 }
    while ($i <= $len1) {
      each {
        var $row { value = [] }
        var $j { value = 0 }
        while ($j <= $len2) {
          each {
            conditional {
              // First row: distance from empty string to str2[0..j-1] = j
              if ($i == 0) {
                var $cell { value = $j }
              }
              // First column: distance from str1[0..i-1] to empty string = i
              elseif ($j == 0) {
                var $cell { value = $i }
              }
              else {
                var $cell { value = 0 }
              }
            }
            var $row { value = $row|merge:[$cell] }
            var.update $j { value = $j + 1 }
          }
        }
        var $dp { value = $dp|merge:[$row] }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Fill the DP matrix
    var.update $i { value = 1 }
    while ($i <= $len1) {
      each {
        var.update $j { value = 1 }
        while ($j <= $len2) {
          each {
            // Get characters at current positions (1-indexed in matrix, 0-indexed in string)
            var $char1_idx { value = $i - 1 }
            var $char2_idx { value = $j - 1 }
            var $char1 { value = $input.str1|substr:$char1_idx:1 }
            var $char2 { value = $input.str2|substr:$char2_idx:1 }
            
            conditional {
              // Characters match - no operation needed
              if ($char1 == $char2) {
                // Copy diagonal value (no new operation)
                var $diag_row { value = $dp|get:($i - 1) }
                var $new_val { value = $diag_row|get:$j }
                var $current_row { value = $dp|get:$i }
                var $updated_row { value = $current_row|set:$j:$new_val }
                var $dp { value = $dp|set:$i:$updated_row }
              }
              // Characters differ - minimum of insert, delete, or replace
              else {
                // Get values for the three operations
                // Delete: remove char from str1 (come from above)
                var $delete_row { value = $dp|get:($i - 1) }
                var $delete_cost { value = $delete_row|get:$j }
                
                // Insert: add char to str1 (come from left)
                var $insert_row { value = $dp|get:$i }
                var $insert_cost { value = $insert_row|get:($j - 1) }
                
                // Replace: change char in str1 to match str2 (come from diagonal)
                var $replace_row { value = $dp|get:($i - 1) }
                var $replace_cost { value = $replace_row|get:($j - 1) }
                
                // Find minimum cost
                var $min_cost { value = $delete_cost }
                conditional {
                  if ($insert_cost < $min_cost) {
                    var.update $min_cost { value = $insert_cost }
                  }
                }
                conditional {
                  if ($replace_cost < $min_cost) {
                    var.update $min_cost { value = $replace_cost }
                  }
                }
                
                // Add 1 for the operation we just performed
                var $new_val { value = $min_cost + 1 }
                var $current_row { value = $dp|get:$i }
                var $updated_row { value = $current_row|set:$j:$new_val }
                var $dp { value = $dp|set:$i:$updated_row }
              }
            }
            var.update $j { value = $j + 1 }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Return the edit distance (bottom-right of matrix)
    var $final_row { value = $dp|get:$len1 }
    var $result { value = $final_row|get:$len2 }
  }
  
  response = $result
}
