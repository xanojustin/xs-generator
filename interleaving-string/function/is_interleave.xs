// Interleaving String - Dynamic Programming exercise
// Determines whether s3 is formed by interleaving s1 and s2
// An interleaving preserves the relative order of characters from each string
function "is_interleave" {
  description = "Determines if s3 can be formed by interleaving s1 and s2"

  input {
    text s1 { description = "First source string" }
    text s2 { description = "Second source string" }
    text s3 { description = "Target string to check" }
  }

  stack {
    // Get lengths of all strings
    var $len1 { value = $input.s1|strlen }
    var $len2 { value = $input.s2|strlen }
    var $len3 { value = $input.s3|strlen }

    // Quick length check: s3 must equal s1.length + s2.length
    conditional {
      if ($len1 + $len2 != $len3) {
        return { value = false }
      }
    }

    // Edge cases: empty strings
    conditional {
      if ($len1 == 0) {
        return { value = $input.s1 ~ $input.s2 == $input.s3 }
      }
    }

    conditional {
      if ($len2 == 0) {
        return { value = $input.s1 == $input.s3 }
      }
    }

    // Create DP table: dp[i][j] = true if s3[0..i+j-1] can be formed
    // by interleaving s1[0..i-1] and s2[0..j-1]
    var $dp { value = [] }

    // Initialize dp table with false values
    var $i { value = 0 }
    while ($i <= $len1) {
      each {
        var $row { value = [] }
        var $j { value = 0 }
        while ($j <= $len2) {
          each {
            array.push $row {
              value = false
            }
            math.add $j { value = 1 }
          }
        }
        array.push $dp {
          value = $row
        }
        math.add $i { value = 1 }
      }
    }

    // Base case: empty s1 and empty s2 can form empty s3
    var.update $dp[0] { value = $dp[0]|set:0:true }

    // Fill first row: using only s2 characters
    var $j { value = 1 }
    while ($j <= $len2) {
      each {
        // Get character from s2 at position j-1
        var $s2_char { value = $input.s2[$j - 1] }
        var $s3_char { value = $input.s3[$j - 1] }

        conditional {
          if ($dp[0][$j - 1] && $s2_char == $s3_char) {
            var.update $dp[0] { value = $dp[0]|set:$j:true }
          }
        }
        math.add $j { value = 1 }
      }
    }

    // Fill first column: using only s1 characters
    var.update $i { value = 1 }
    while ($i <= $len1) {
      each {
        // Get character from s1 at position i-1
        var $s1_char { value = $input.s1[$i - 1] }
        var $s3_char { value = $input.s3[$i - 1] }

        conditional {
          if ($dp[$i - 1][0] && $s1_char == $s3_char) {
            var.update $dp[$i] { value = $dp[$i]|set:0:true }
          }
        }
        math.add $i { value = 1 }
      }
    }

    // Fill the rest of the DP table
    var.update $i { value = 1 }
    while ($i <= $len1) {
      each {
        var.update $j { value = 1 }
        while ($j <= $len2) {
          each {
            // Current position in s3
            var $s3_pos { value = $i + $j - 1 }
            var $s3_char { value = $input.s3[$s3_pos] }
            var $s1_char { value = $input.s1[$i - 1] }
            var $s2_char { value = $input.s2[$j - 1] }

            // Check if we can come from above (using s1[i-1])
            conditional {
              if ($dp[$i - 1][$j] && $s1_char == $s3_char) {
                var.update $dp[$i] { value = $dp[$i]|set:$j:true }
              }
            }

            // Check if we can come from left (using s2[j-1])
            conditional {
              if ($dp[$i][$j - 1] && $s2_char == $s3_char) {
                var.update $dp[$i] { value = $dp[$i]|set:$j:true }
              }
            }

            math.add $j { value = 1 }
          }
        }
        math.add $i { value = 1 }
      }
    }
  }

  response = $dp[$len1][$len2]
}
