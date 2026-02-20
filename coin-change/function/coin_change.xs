// Coin Change - Dynamic Programming Exercise
// Given coin denominations and a target amount, find the minimum number of coins needed
function "coin_change" {
  description = "Finds minimum coins needed to make up the target amount"
  
  input {
    int[] coins { description = "Array of coin denominations available" }
    int amount { description = "Target amount to make up" }
  }
  
  stack {
    // Edge case: amount 0 requires 0 coins
    conditional {
      if ($input.amount == 0) {
        return { value = 0 }
      }
    }
    
    // Initialize DP array: dp[i] = minimum coins needed for amount i
    // Start with a value larger than any possible answer (amount + 1)
    var $dp { value = [] }
    var $i { value = 0 }
    
    // Initialize dp array with "infinity" (amount + 1 is larger than max possible)
    while ($i <= $input.amount) {
      each {
        var $dp { value = $dp|merge:[$input.amount + 1] }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Base case: 0 coins needed to make amount 0
    var.update $dp[0] { value = 0 }
    
    // Fill the DP table
    var $amt { value = 1 }
    while ($amt <= $input.amount) {
      each {
        // Try each coin
        foreach ($input.coins) {
          each as $coin {
            conditional {
              if ($coin <= $amt) {
                // If we can use this coin, check if it gives a better solution
                var $remaining { value = $amt - $coin }
                var $candidate { value = $dp[$remaining] + 1 }
                conditional {
                  if ($candidate < $dp[$amt]) {
                    var.update $dp[$amt] { value = $candidate }
                  }
                }
              }
            }
          }
        }
        var.update $amt { value = $amt + 1 }
      }
    }
    
    // Return result: if dp[amount] is still "infinity", no solution exists
    conditional {
      if ($dp[$input.amount] > $input.amount) {
        return { value = -1 }
      }
    }
    
    return { value = $dp[$input.amount] }
  }
  
  response = $response
}
