// 0/1 Knapsack Problem - Classic dynamic programming exercise
// Given weights and values of items, and a knapsack capacity,
// return the maximum value that can be obtained
function "knapsack" {
  description = "Solves the 0/1 Knapsack problem using dynamic programming"
  
  input {
    int[] weights { description = "Array of item weights" }
    int[] values { description = "Array of item values" }
    int capacity { description = "Maximum weight capacity of knapsack" }
  }
  
  stack {
    // Get number of items
    var $n { value = $input.weights|count }
    
    // Handle edge cases - store result in a variable
    var $result { value = null }
    
    conditional {
      if ($n == 0 || $input.capacity <= 0) {
        var $result { value = 0 }
      }
      else {
        // Initialize DP array - dp[j] represents max value for capacity j
        var $dp { value = [] }
        var $j { value = 0 }
        
        while ($j <= $input.capacity) {
          each {
            var $dp {
              value = $dp|merge:[0]
            }
            var.update $j { value = $j + 1 }
          }
        }
        
        // Process each item
        var $i { value = 0 }
        
        while ($i < $n) {
          each {
            // Get current item's weight and value
            var $w { value = $input.weights[$i] }
            var $v { value = $input.values[$i] }
            
            // Update DP array from right to left
            var $c { value = $input.capacity }
            
            while ($c >= $w) {
              each {
                // If taking this item gives better value, update dp[c]
                conditional {
                  if ($dp[$c - $w] + $v > $dp[$c]) {
                    var $new_val { value = $dp[$c - $w] + $v }
                    var $dp_before { value = $dp|slice:0:$c }
                    var $dp_after { value = $dp|slice:($c + 1):($dp|count) }
                    var $dp { value = $dp_before|merge:[$new_val]|merge:$dp_after }
                  }
                }
                var.update $c { value = $c - 1 }
              }
            }
            
            var.update $i { value = $i + 1 }
          }
        }
        
        var $result { value = $dp[$input.capacity] }
      }
    }
  }
  
  response = $result
}
