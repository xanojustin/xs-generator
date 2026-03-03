// Stone Game - Dynamic Programming exercise
// Alex and Lee play a game with piles of stones arranged in a row.
// Each turn, a player takes the entire pile from either end.
// Both play optimally. Return true if Alex (first player) wins.
//
// This uses DP with dp[i][j] = max score difference for piles i to j.
// The first player wins if dp[0][n-1] > 0.
function "stone_game" {
  description = "Determines if the first player wins the stone game with optimal play"
  
  input {
    int[] piles { description = "Array of stone piles (even length, positive values)" }
  }
  
  stack {
    var $n { value = $input.piles|count }
    
    // Edge case: empty piles
    conditional {
      if ($n == 0) {
        return { value = false }
      }
    }
    
    // Edge case: single pile
    conditional {
      if ($n == 1) {
        return { value = true }
      }
    }
    
    // Initialize DP table as a 2D array (array of arrays)
    // dp[i][j] = max score difference (current - opponent) for piles i..j
    var $dp { value = [] }
    
    // Initialize all rows with zeros
    for ($n) {
      each as $i {
        var $row { value = [] }
        for ($n) {
          each as $j {
            var $row { value = $row|merge:[0] }
          }
        }
        var $dp { value = $dp|merge:[$row] }
      }
    }
    
    // Fill the DP table
    // Start with subarrays of length 1, then 2, etc.
    var $length { value = 1 }
    
    while ($length <= $n) {
      each {
        var $i { value = 0 }
        
        while ($i <= $n - $length) {
          each {
            var $j { value = $i + $length - 1 }
            
            conditional {
              if ($i == $j) {
                // Base case: only one pile
                // Get the pile value at index i
                var $pile_value_i { value = $input.piles|get:$i }
                var $dp_i { value = $dp|get:$i }
                var $dp_i_updated { value = $dp_i|set:$j:$pile_value_i }
                var $dp { value = $dp|set:$i:$dp_i_updated }
              }
              else {
                // Recurrence: max of taking left or right pile
                // dp[i][j] = max(piles[i] - dp[i+1][j], piles[j] - dp[i][j-1])
                
                var $pile_left { value = $input.piles|get:$i }
                var $pile_right { value = $input.piles|get:$j }
                
                // Get dp[i+1][j]
                var $dp_ip1 { value = $dp|get:($i + 1) }
                var $dp_i1j { value = $dp_ip1|get:$j }
                
                // Get dp[i][j-1]
                var $dp_i { value = $dp|get:$i }
                var $dp_ij1 { value = $dp_i|get:($j - 1) }
                
                // Calculate options
                var $take_left { value = $pile_left - $dp_i1j }
                var $take_right { value = $pile_right - $dp_ij1 }
                
                // Get max
                conditional {
                  if ($take_left >= $take_right) {
                    var $dp_i_new { value = $dp|get:$i }
                    var $dp_i_updated { value = $dp_i_new|set:$j:$take_left }
                    var $dp { value = $dp|set:$i:$dp_i_updated }
                  }
                  else {
                    var $dp_i_new { value = $dp|get:$i }
                    var $dp_i_updated { value = $dp_i_new|set:$j:$take_right }
                    var $dp { value = $dp|set:$i:$dp_i_updated }
                  }
                }
              }
            }
            
            var.update $i { value = $i + 1 }
          }
        }
        
        var.update $length { value = $length + 1 }
      }
    }
    
    // Result: Alex wins if dp[0][n-1] > 0
    var $dp_0 { value = $dp|get:0 }
    var $result { value = $dp_0|get:($n - 1) }
    
    var $alex_wins { value = $result > 0 }
  }
  
  response = $alex_wins
}
