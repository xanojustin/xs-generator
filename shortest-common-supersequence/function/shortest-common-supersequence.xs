function "shortest-common-supersequence" {
  description = "Find the shortest common supersequence of two strings"
  input {
    text str1
    text str2
  }
  stack {
    // Get lengths of both strings
    var $m { value = $input.str1|strlen }
    var $n { value = $input.str2|strlen }
    
    // Build LCS DP table
    // dp[i][j] = length of LCS of str1[0..i-1] and str2[0..j-1]
    var $dp { value = [] }
    
    // Initialize dp table with zeros
    for (($m + 1)) {
      each as $i {
        var $row { value = [] }
        for (($n + 1)) {
          each as $j {
            var.update $row { value = $row|append:0 }
          }
        }
        var.update $dp { value = $dp|append:$row }
      }
    }
    
    // Fill DP table bottom-up
    for ($m) {
      each as $i {
        for ($n) {
          each as $j {
            // Get characters at current positions (1-indexed in DP)
            var $c1 { value = $input.str1|substr:$i:1 }
            var $c2 { value = $input.str2|substr:$j:1 }
            
            conditional {
              if ($c1 == $c2) {
                // Characters match - extend LCS
                var $prev_row { value = $dp|get:(($i - 1)|to_int) }
                var $prev_val { value = $prev_row|get:(($j - 1)|to_int) }
                var $curr_row { value = $dp|get:$i }
                var $new_row { value = $curr_row|set:$j:($prev_val + 1) }
                var.update $dp { value = $dp|set:$i:$new_row }
              }
              else {
                // Characters don't match - take max of excluding either
                var $row_i_minus_1 { value = $dp|get:(($i - 1)|to_int) }
                var $val_i_minus_1 { value = $row_i_minus_1|get:$j }
                var $row_i { value = $dp|get:$i }
                var $val_j_minus_1 { value = $row_i|get:(($j - 1)|to_int) }
                
                conditional {
                  if ($val_i_minus_1 > $val_j_minus_1) {
                    var $new_row { value = $row_i|set:$i:$val_i_minus_1 }
                    var.update $dp { value = $dp|set:$i:$new_row }
                  }
                  else {
                    var $new_row { value = $row_i|set:$i:$val_j_minus_1 }
                    var.update $dp { value = $dp|set:$i:$new_row }
                  }
                }
              }
            }
          }
        }
      }
    }
    
    // Backtrack to build the result
    var $result { value = "" }
    var $i { value = ($m - 1)|to_int }
    var $j { value = ($n - 1)|to_int }
    
    while (($i >= 0) || ($j >= 0)) {
      each {
        conditional {
          if (($i < 0) && ($j >= 0)) {
            // Only str2 remaining
            var $c { value = $input.str2|substr:$j:1 }
            var.update $result { value = $c ~ $result }
            var.update $j { value = $j - 1 }
          }
          elseif (($j < 0) && ($i >= 0)) {
            // Only str1 remaining
            var $c { value = $input.str1|substr:$i:1 }
            var.update $result { value = $c ~ $result }
            var.update $i { value = $i - 1 }
          }
          elseif (($input.str1|substr:$i:1) == ($input.str2|substr:$j:1)) {
            // Characters match - part of LCS
            var $c { value = $input.str1|substr:$i:1 }
            var.update $result { value = $c ~ $result }
            var.update $i { value = $i - 1 }
            var.update $j { value = $j - 1 }
          }
          else {
            // Choose direction based on DP table
            var $row_i { value = $dp|get:$i }
            var $row_i_minus_1 { value = $dp|get:(($i - 1)|to_int) }
            var $val_up { value = $row_i_minus_1|get:$j }
            var $val_left { value = $row_i|get:(($j - 1)|to_int) }
            
            conditional {
              if ($val_up > $val_left) {
                // Move up - take from str1
                var $c { value = $input.str1|substr:$i:1 }
                var.update $result { value = $c ~ $result }
                var.update $i { value = $i - 1 }
              }
              else {
                // Move left - take from str2
                var $c { value = $input.str2|substr:$j:1 }
                var.update $result { value = $c ~ $result }
                var.update $j { value = $j - 1 }
              }
            }
          }
        }
      }
    }
  }
  response = $result
}