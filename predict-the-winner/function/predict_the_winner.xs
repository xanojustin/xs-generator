function "predict_the_winner" {
  description = "Determine if Player 1 can win the prediction game"
  input {
    int[] nums
  }
  stack {
    // Get the length of the array
    var $n { value = $input.nums|count }
    
    // Edge case: empty array - Player 1 cannot win
    conditional {
      if ($n == 0) {
        var $can_win { value = false }
      }
      elseif ($n == 1) {
        // Only one number, Player 1 takes it and wins
        var $can_win { value = true }
      }
      else {
        // Use dynamic programming approach
        // dp[i][j] = maximum score difference (current - opponent) for subarray i..j
        // We use a 1D array where index = i * n + j represents dp[i][j]
        
        // Initialize dp array with zeros
        var $dp { value = [] }
        var $total_cells { value = $n * $n }
        var $init_idx { value = 0 }
        while ($init_idx < $total_cells) {
          each {
            var $dp { value = $dp|append:0 }
            var.update $init_idx { value = $init_idx + 1 }
          }
        }
        
        // Base case: single element subarrays - dp[i][i] = nums[i]
        var $base_i { value = 0 }
        while ($base_i < $n) {
          each {
            var $val { value = $input.nums|get:($base_i|to_text) }
            var $idx { value = $base_i * $n + $base_i }
            var $dp { value = $dp|set:($idx|to_text):$val }
            var.update $base_i { value = $base_i + 1 }
          }
        }
        
        // Fill dp table for subarrays of length 2 to n
        var $length { value = 2 }
        while ($length <= $n) {
          each {
            var $i { value = 0 }
            var $max_i { value = $n - $length }
            while ($i <= $max_i) {
              each {
                var $j { value = $i + $length - 1 }
                
                // Get values at both ends
                var $left_val { value = $input.nums|get:($i|to_text) }
                var $right_val { value = $input.nums|get:($j|to_text) }
                
                // After picking left, opponent plays on (i+1, j)
                // Our net score = left_val - dp[i+1][j]
                var $left_next_idx { value = ($i + 1) * $n + $j }
                var $left_next { value = $dp|get:($left_next_idx|to_text) }
                var $score_left { value = $left_val - $left_next }
                
                // After picking right, opponent plays on (i, j-1)
                // Our net score = right_val - dp[i][j-1]
                var $right_next_idx { value = $i * $n + ($j - 1) }
                var $right_next { value = $dp|get:($right_next_idx|to_text) }
                var $score_right { value = $right_val - $right_next }
                
                // Pick the better option
                var $best { value = $score_left }
                conditional {
                  if ($score_right > $score_left) {
                    var.update $best { value = $score_right }
                  }
                }
                
                // Store result
                var $curr_idx { value = $i * $n + $j }
                var $dp { value = $dp|set:($curr_idx|to_text):$best }
                
                var.update $i { value = $i + 1 }
              }
            }
            var.update $length { value = $length + 1 }
          }
        }
        
        // Result is dp[0][n-1] - if >= 0, Player 1 wins or ties
        var $final_idx { value = $n - 1 }
        var $final_score { value = $dp|get:($final_idx|to_text) }
        var $can_win { value = $final_score >= 0 }
      }
    }
  }
  response = $can_win
}
