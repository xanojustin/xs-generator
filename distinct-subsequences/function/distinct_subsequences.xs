// Distinct Subsequences - Dynamic Programming Exercise
// Given two strings s and t, count how many times t appears as a subsequence of s.
// A subsequence is formed by deleting characters without changing the order of remaining characters.
//
// Example: s = "rabbbit", t = "rabbit" -> 3
// Explanation: The three ways to form "rabbit" from "rabbbit" are by deleting one of the three 'b's.
//
// Uses 1D DP optimization: dp[j] represents ways to form t[0:j] from processed s characters
function "distinct_subsequences" {
  description = "Count distinct subsequences of t in s using dynamic programming"
  
  input {
    text s { description = "Source string to search within" }
    text t { description = "Target string to find as subsequence" }
  }
  
  stack {
    // Get lengths of both strings
    var $s_len { value = $input.s|strlen }
    var $t_len { value = $input.t|strlen }
    
    // Edge case: empty t is a subsequence of any string exactly once
    conditional {
      if (`$t_len == 0`) {
        return { value = 1 }
      }
    }
    
    // Edge case: if t is longer than s, t cannot be a subsequence
    conditional {
      if (`$t_len > $s_len`) {
        return { value = 0 }
      }
    }
    
    // Convert strings to arrays of characters for indexing
    var $s_chars { value = $input.s|split:"" }
    var $t_chars { value = $input.t|split:"" }
    
    // DP array: dp[j] = number of ways to form t[0..j-1] from processed s characters
    // Initialize with 1 way to form empty string (dp[0] = 1)
    var $dp { value = [] }
    var $j { value = 0 }
    while (`$j <= $t_len`) {
      each {
        conditional {
          if (`$j == 0`) {
            var $dp { value = $dp|push:1 }
          }
          else {
            var $dp { value = $dp|push:0 }
          }
        }
        var.update $j { value = $j + 1 }
      }
    }
    
    // Process each character in s
    var $i { value = 0 }
    while (`$i < $s_len`) {
      each {
        // Get current character from s
        var $s_char { value = $s_chars|get:$i }
        
        // Iterate backwards through t to avoid using updated values
        // Must go from t_len down to 1
        var $j { value = $t_len }
        while (`$j >= 1`) {
          each {
            // Get current character from t (0-indexed, so j-1)
            var $t_char { value = $t_chars|get:($j - 1) }
            
            // If characters match, add ways from previous state
            conditional {
              if (`$s_char == $t_char`) {
                // dp[j] += dp[j-1]
                var $prev_val { value = $dp|get:($j - 1) }
                var $curr_val { value = $dp|get:$j }
                var $new_val { value = $curr_val + $prev_val }
                var $dp { 
                  value = $dp|set:($j|to_text):$new_val 
                }
              }
            }
            
            var.update $j { value = $j - 1 }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
    
    // Result is dp[t_len] - ways to form entire t from s
    var $result { value = $dp|get:$t_len }
  }
  
  response = $result
}
