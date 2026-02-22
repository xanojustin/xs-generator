function "wildcard_match" {
  description = "Check if a string matches a pattern with wildcards (? and *)"
  input {
    text s { description = "The input string to match" }
    text p { description = "The pattern containing ? and * wildcards" }
  }
  stack {
    // Get lengths of string and pattern
    var $s_len { value = $input.s|strlen }
    var $p_len { value = $input.p|strlen }
    
    // Edge cases
    conditional {
      if ($p_len == 0) {
        return { value = ($s_len == 0) }
      }
    }
    
    // dp[i][j] = true if s[0..i-1] matches p[0..j-1]
    // We'll use a 1D array approach for space efficiency
    // dp[j] represents matching s[0..current_i-1] with p[0..j-1]
    
    // Initialize dp array for empty string matching
    var $dp { value = [] }
    var $j { value = 0 }
    
    // dp[0] = true (empty string matches empty pattern)
    var.update $dp { value = $dp|append:true }
    
    // Initialize: empty string can match pattern like "*", "**", etc.
    while ($j < $p_len) {
      each {
        // Get character at position j using substring
        var $p_char { value = $input.p|substr:$j:1 }
        conditional {
          if ($p_char == "*") {
            // * can match empty string, so dp[j+1] = dp[j]
            var $prev_val { value = $dp[$j] }
            var.update $dp { value = $dp|append:$prev_val }
          }
          else {
            // Any other char can't match empty string
            var.update $dp { value = $dp|append:false }
          }
        }
        var.update $j { value = $j + 1 }
      }
    }
    
    // Process each character in s
    var $i { value = 0 }
    while ($i < $s_len) {
      each {
        // Get character at position i using substring
        var $s_char { value = $input.s|substr:$i:1 }
        // dp[0] is always false for non-empty s
        var $new_dp { value = [false] }
        
        var $j { value = 0 }
        while ($j < $p_len) {
          each {
            // Get character at position j using substring
            var $p_char { value = $input.p|substr:$j:1 }
            var $match { value = false }
            
            conditional {
              if ($p_char == "*") {
                // * matches empty (dp[j]) or one+ chars (new_dp[j+1] if previous matched)
                var $empty_match { value = $dp[$j + 1] }
                var $char_match { value = $new_dp[$j] }
                var.update $match { value = $empty_match || $char_match }
              }
              elseif ($p_char == "?") {
                // ? matches any single char, so check if previous chars matched
                var.update $match { value = $dp[$j] }
              }
              else {
                // Exact char match required
                conditional {
                  if ($s_char == $p_char) {
                    var.update $match { value = $dp[$j] }
                  }
                }
              }
            }
            
            var.update $new_dp { value = $new_dp|append:$match }
            var.update $j { value = $j + 1 }
          }
        }
        
        var.update $dp { value = $new_dp }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Final result is dp[p_len]
    var $result { value = $dp[$p_len] }
  }
  response = $result
}
