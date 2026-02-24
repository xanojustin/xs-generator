// Best Time to Buy and Sell Stock II
// Classic coding exercise: Given stock prices, find max profit with unlimited transactions
// Uses greedy approach - accumulate all positive daily differences
function "max_profit_ii" {
  description = "Finds maximum profit from buying and selling stock multiple times"
  
  input {
    int[] prices { description = "Array of stock prices where prices[i] is price on day i" }
  }
  
  stack {
    // Edge case: need at least 2 days to make any profit
    conditional {
      if (($input.prices|count) < 2) {
        var $total_profit { value = 0 }
      }
      else {
        // Initialize total profit to 0
        var $total_profit { value = 0 }
        
        // Iterate through prices starting from day 1
        var $i { value = 1 }
        
        while ($i < ($input.prices|count)) {
          each {
            // Get today's price and yesterday's price
            var $today_price { 
              value = $input.prices[$i] 
            }
            var $yesterday_price { 
              value = $input.prices[$i - 1] 
            }
            
            // Calculate daily difference
            var $daily_diff { 
              value = $today_price - $yesterday_price 
            }
            
            // Add positive differences to total profit
            // This captures every upward price movement
            conditional {
              if ($daily_diff > 0) {
                var $total_profit { 
                  value = $total_profit + $daily_diff 
                }
              }
            }
            
            // Move to next day
            var.update $i { value = $i + 1 }
          }
        }
      }
    }
  }
  
  response = $total_profit
}
