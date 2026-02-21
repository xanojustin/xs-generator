// Best Time to Buy and Sell Stock
// Classic coding exercise: Given stock prices, find max profit from one buy/sell
// Uses single pass O(n) approach tracking minimum price and max profit
function "max_profit" {
  description = "Finds maximum profit from buying and selling stock once"
  
  input {
    int[] prices { description = "Array of stock prices where prices[i] is price on day i" }
  }
  
  stack {
    // Edge case: empty array or single element
    conditional {
      if (($input.prices|count) < 2) {
        var $max_profit { value = 0 }
      }
      else {
        // Initialize min_price to first element and max_profit to 0
        var $min_price { value = $input.prices|first }
        var $max_profit { value = 0 }
        
        // Use manual index counter since foreach doesn't provide index
        var $index { value = 0 }
        
        foreach ($input.prices) {
          each as $price {
            // Skip first element (we need at least 2 days to make a transaction)
            conditional {
              if ($index > 0) {
                // Calculate potential profit if we sell today
                var $potential_profit { value = $price - $min_price }
                
                // Update max_profit if this is better
                conditional {
                  if ($potential_profit > $max_profit) {
                    var $max_profit { value = $potential_profit }
                  }
                }
                
                // Update min_price if current price is lower
                conditional {
                  if ($price < $min_price) {
                    var $min_price { value = $price }
                  }
                }
              }
            }
            
            var.update $index { value = $index + 1 }
          }
        }
      }
    }
  }
  
  response = $max_profit
}
