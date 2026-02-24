function "min_cost_climbing_stairs" {
  description = "Calculate minimum cost to reach the top of stairs, where you can climb 1 or 2 steps at a time"
  input {
    int[] costs
  }
  stack {
    // Handle edge cases
    conditional {
      if (`($input.costs|count) == 0`) {
        return { value = 0 }
      }
      elseif (`($input.costs|count) == 1`) {
        return { value = $input.costs[0] }
      }
    }
    
    // Dynamic programming approach
    // dp[i] = minimum cost to reach step i
    // We only need to track the previous two steps for O(1) space
    
    // Cost to reach step 0
    var $prev2 { value = $input.costs[0] }
    // Cost to reach step 1
    var $prev1 { value = $input.costs[1] }
    
    // Iterate from step 2 to the end
    var $i { value = 2 }
    while (`$i < ($input.costs|count)`) {
      each {
        // Cost to reach step i = cost[i] + min(cost to reach i-1, cost to reach i-2)
        conditional {
          if (`$prev1 < $prev2`) {
            var $current { 
              value = $input.costs[$i] + $prev1
            }
          }
          else {
            var $current { 
              value = $input.costs[$i] + $prev2
            }
          }
        }
        var.update $prev2 { value = $prev1 }
        var.update $prev1 { value = $current }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Return minimum of reaching from second-to-last or last step
    conditional {
      if (`$prev1 < $prev2`) {
        var $min_cost { value = $prev1 }
      }
      else {
        var $min_cost { value = $prev2 }
      }
    }
  }
  response = $min_cost
}
