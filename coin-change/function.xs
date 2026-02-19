function "coin_change" {
  description = "Find the minimum number of coins needed to make a given amount"
  input {
    int[] coins {
      description = "Array of coin denominations (must be positive integers)"
    }
    int amount filters=min:0 {
      description = "The target amount to make (must be >= 0)"
    }
  }
  stack {
    // Edge case: if amount is 0, no coins needed
    conditional {
      if ($input.amount == 0) {
        var $result { value = 0 }
      }
      else {
        // Initialize dp array with a large value (amount + 1 represents infinity)
        // dp[i] will store the minimum coins needed to make amount i
        var $dp { value = [] }
        var $i { value = 0 }
        
        // Fill dp array with "infinity" value (amount + 1)
        while ($i <= $input.amount) {
          each {
            var.update $dp { value = $dp|push:($input.amount + 1) }
            var.update $i { value = $i + 1 }
          }
        }
        
        // Base case: 0 coins needed to make amount 0
        var.update $dp { value = $dp|set:"0":0 }
        
        // Build solution for each amount from 1 to target amount
        var $current_amount { value = 1 }
        
        while ($current_amount <= $input.amount) {
          each {
            // Try each coin denomination
            foreach ($input.coins) {
              each as $coin {
                conditional {
                  // Only consider if coin value is <= current amount
                  if ($coin <= $current_amount) {
                    // Get the previous dp value for (current_amount - coin)
                    var $prev_index { value = $current_amount - $coin }
                    var $prev_value { value = $dp[$prev_index] }
                    var $current_value { value = $dp[$current_amount] }
                    
                    // If using this coin gives a better solution, update dp
                    conditional {
                      if (($prev_value + 1) < $current_value) {
                        var.update $dp { 
                          value = $dp|set:($current_amount|to_text):($prev_value + 1) 
                        }
                      }
                    }
                  }
                }
              }
            }
            var.update $current_amount { value = $current_amount + 1 }
          }
        }
        
        // Check if we found a valid solution
        var $final_value { value = $dp[$input.amount] }
        conditional {
          if ($final_value > $input.amount) {
            // No valid combination found
            var $result { value = -1 }
          }
          else {
            var $result { value = $final_value }
          }
        }
      }
    }
  }
  response = $result
}
