// Longest Common Subsequence (LCS) - Dynamic Programming Solution
// Finds the length of the longest subsequence present in both strings
// A subsequence is a sequence that appears in the same relative order, but not necessarily contiguous
function "lcs" {
  description = "Calculate the length of the longest common subsequence between two strings"
  
  input {
    text str1 { description = "First string" }
    text str2 { description = "Second string" }
  }
  
  stack {
    // Get lengths of both strings
    var $len1 { value = $input.str1|strlen }
    var $len2 { value = $input.str2|strlen }
    
    // Handle edge cases - if either string is empty, LCS is 0
    conditional {
      if ($len1 == 0) {
        return { value = 0 }
      }
    }
    
    conditional {
      if ($len2 == 0) {
        return { value = 0 }
      }
    }
    
    // Create DP matrix as an array of arrays
    // dp[i][j] = length of LCS of str1[0..i-1] and str2[0..j-1]
    var $dp { value = [] }
    
    // Initialize the DP matrix with zeros
    var $i { value = 0 }
    while ($i <= $len1) {
      each {
        var $row { value = [] }
        var $j { value = 0 }
        while ($j <= $len2) {
          each {
            var $row { value = $row|merge:[0] }
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
              // Characters match - extend the subsequence
              if ($char1 == $char2) {
                // Get diagonal value and add 1
                var $diag_row { value = $dp|get:($i - 1) }
                var $diag_val { value = $diag_row|get:($j - 1) }
                var $new_val { value = $diag_val + 1 }
                var $current_row { value = $dp|get:$i }
                var $updated_row { value = $current_row|set:$j:$new_val }
                var $dp { value = $dp|set:$i:$updated_row }
              }
              // Characters differ - take maximum of excluding either character
              else {
                // Value from above (exclude current char from str1)
                var $above_row { value = $dp|get:($i - 1) }
                var $above_val { value = $above_row|get:$j }
                
                // Value from left (exclude current char from str2)
                var $left_row { value = $dp|get:$i }
                var $left_val { value = $left_row|get:($j - 1) }
                
                // Take maximum
                conditional {
                  if ($above_val >= $left_val) {
                    var $new_val { value = $above_val }
                  }
                  else {
                    var $new_val { value = $left_val }
                  }
                }
                
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
    
    // Return the LCS length (bottom-right of matrix)
    var $final_row { value = $dp|get:$len1 }
    var $result { value = $final_row|get:$len2 }
  }
  
  response = $result
}
