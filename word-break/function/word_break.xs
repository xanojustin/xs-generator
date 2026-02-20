function "word_break" {
  description = "Determine if a string can be segmented into dictionary words using dynamic programming"
  input {
    text s
    text[] wordDict
  }
  stack {
    // Edge case: empty string
    conditional {
      if ($input.s == "") {
        return { value = true }
      }
    }

    // Get the length of the string
    var $n { value = $input.s|strlen }

    // dp[i] = true if s[0..i-1] can be segmented
    var $dp { value = [] }

    // Initialize dp array with false
    for ($n + 1) {
      each as $i {
        var $dp { value = $dp|merge:[false] }
      }
    }

    // Empty string can always be segmented
    var $dp { value = $dp|merge:[true] }

    // Build the dp array
    var $i { value = 1 }
    while ($i <= $n) {
      each {
        var $j { value = 0 }
        while ($j < $i) {
          each {
            // Check if substring from j to i is in dictionary
            var $substring { value = $input.s|slice:$j:($i - $j) }

            conditional {
              if ($dp[$j] == true && ($input.wordDict|contains:$substring)) {
                var $dp { value = $dp|set:$i:true }
              }
            }

            var $j { value = $j + 1 }
          }
        }
        var $i { value = $i + 1 }
      }
    }
  }
  response = $dp[$n]
}
