// Regular Expression Matching - Dynamic Programming Solution
// Implements regex matching with support for '.' and '*'
// '.' matches any single character
// '*' matches zero or more of the preceding element
function "regular-expression-matching" {
  description = "Check if string s matches pattern p with . and * support"
  
  input {
    text s { description = "Input string to match" }
    text p { description = "Pattern containing letters, ., and *" }
  }
  
  stack {
    // Get lengths of string and pattern
    var $s_len { value = $input.s|strlen }
    var $p_len { value = $input.p|strlen }
    
    // Create DP table: dp[i][j] = true if s[0..i-1] matches p[0..j-1]
    // Using 1D array to represent 2D matrix for simplicity
    var $dp { value = [] }
    
    // Initialize DP table with false values
    var $i { value = 0 }
    while ($i <= $s_len) {
      each {
        var $j { value = 0 }
        while ($j <= $p_len) {
          each {
            var $dp { value = $dp|merge:[false] }
            var.update $j { value = $j + 1 }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Base case: empty string matches empty pattern
    var $dp { value = $dp|set:0:true }
    
    // Handle patterns that can match empty string: a*, a*b*, a*b*c*, etc.
    // dp[0][j] is true if p[j-1] is '*' and dp[0][j-2] is true
    var $j { value = 2 }
    while ($j <= $p_len) {
      each {
        // Check if current pattern char is '*'
        var $p_idx { value = $j - 1 }
        var $p_char { value = $input.p|substr:$p_idx:1 }
        
        conditional {
          if ($p_char == "*") {
            // Check if dp[0][j-2] is true (zero occurrences of preceding char)
            var $prev_idx { value = $j - 2 }
            var $dp_idx { value = $prev_idx }
            var $prev_val { value = $dp|get:$dp_idx }
            
            conditional {
              if ($prev_val == true) {
                var $curr_idx { value = $j }
                var $dp { value = $dp|set:$curr_idx:true }
              }
            }
          }
        }
        var.update $j { value = $j + 2 }
      }
    }
    
    // Fill the DP table
    var.update $i { value = 1 }
    while ($i <= $s_len) {
      each {
        var.update $j { value = 1 }
        while ($j <= $p_len) {
          each {
            // Get current characters
            var $s_idx { value = $i - 1 }
            var $p_idx { value = $j - 1 }
            var $s_char { value = $input.s|substr:$s_idx:1 }
            var $p_char { value = $input.p|substr:$p_idx:1 }
            
            // Calculate current dp index
            var $row_size { value = $p_len + 1 }
            var $curr_dp_idx { value = ($i * $row_size) + $j }
            
            conditional {
              // Case 1: Current pattern char is '*'
              if ($p_char == "*") {
                // Get the preceding character in pattern
                var $prev_p_idx { value = $j - 2 }
                var $prev_p_char { value = $input.p|substr:$prev_p_idx:1 }
                
                // Zero occurrences: ignore the * and its preceding char
                var $zero_idx { value = ($i * $row_size) + ($j - 2) }
                var $zero_val { value = $dp|get:$zero_idx }
                var $result { value = $zero_val }
                
                // One or more occurrences: if prev char matches s[i-1]
                conditional {
                  if ($prev_p_char == $s_char || $prev_p_char == ".") {
                    var $more_idx { value = (($i - 1) * $row_size) + $j }
                    var $more_val { value = $dp|get:$more_idx }
                    
                    conditional {
                      if ($more_val == true || $zero_val == true) {
                        var.update $result { value = true }
                      }
                    }
                  }
                }
                
                var $dp { value = $dp|set:$curr_dp_idx:$result }
              }
              // Case 2: Current pattern char matches s_char or is '.'
              elseif ($p_char == $s_char || $p_char == ".") {
                var $diag_idx { value = (($i - 1) * $row_size) + ($j - 1) }
                var $diag_val { value = $dp|get:$diag_idx }
                var $dp { value = $dp|set:$curr_dp_idx:$diag_val }
              }
              // Case 3: No match
              else {
                var $dp { value = $dp|set:$curr_dp_idx:false }
              }
            }
            
            var.update $j { value = $j + 1 }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Return dp[s_len][p_len]
    var $final_idx { value = ($s_len * $row_size) + $p_len }
    var $result { value = $dp|get:$final_idx }
  }
  
  response = $result
}
