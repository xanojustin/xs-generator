function "rod_cutting" {
  description = "Solve the rod cutting problem using dynamic programming"
  input {
    int[] prices { description = "Array of prices where prices[i] is the price for a rod of length i+1" }
    int rod_length filters=min:0 { description = "Length of the rod to cut" }
  }
  stack {
    // Handle edge case: rod of length 0 or empty prices
    conditional {
      if ($input.rod_length == 0 || ($input.prices|count) == 0) {
        return { value = 0 }
      }
    }

    // dp[i] will store the maximum value obtainable for a rod of length i
    var $dp { value = [] }
    
    // Initialize dp[0] = 0 (rod of length 0 has value 0)
    var.update $dp { value = $dp|append:0 }
    
    // Build the dp table bottom-up
    // For each possible rod length from 1 to rod_length
    var $n { value = $input.rod_length }
    var $i { value = 1 }
    
    while ($i <= $n) {
      each {
        var $max_val { value = 0 }
        
        // Try all possible first cuts
        // For a rod of length i, try cutting at position j (1 to i)
        var $j { value = 1 }
        while ($j <= $i) {
          each {
            // Get price for length j (prices are 0-indexed, so j-1)
            // Only use price if j is within bounds of prices array
            conditional {
              if ($j <= ($input.prices|count)) {
                var $current_price { value = $input.prices|slice:($j - 1):1|first }
                var $remaining_value { value = $dp|slice:($i - $j):1|first }
                var $candidate { value = $current_price + $remaining_value }
                
                conditional {
                  if ($candidate > $max_val) {
                    var.update $max_val { value = $candidate }
                  }
                }
              }
            }
            // Increment inner loop counter
            var.update $j { value = $j + 1 }
          }
        }
        
        // Store the maximum value for rod length i
        var.update $dp { value = $dp|append:$max_val }
        // Increment outer loop counter
        var.update $i { value = $i + 1 }
      }
    }
    
    // Return the maximum value for the full rod length
    var $result { value = $dp|slice:$input.rod_length:1|first }
  }
  response = $result
}
