function "house-robber" {
  description = "Calculate maximum money that can be robbed from houses without robbing adjacent houses"
  
  input {
    int[] nums { description = "Array where nums[i] is the money in house i" }
  }
  
  stack {
    // Handle edge cases
    conditional {
      if (($input.nums|count) == 0) {
        return { value = 0 }
      }
      elseif (($input.nums|count) == 1) {
        return { value = $input.nums|first }
      }
    }
    
    // Initialize DP variables
    // prev2 = dp[i-2], prev1 = dp[i-1]
    var $prev2 { value = $input.nums|first }
    var $prev1 { value = (`$input.nums|first` >= `$input.nums|slice:1:2|first`) ? (`$input.nums|first`) : (`$input.nums|slice:1:2|first`) }
    
    // Iterate through remaining houses
    var $i { value = 2 }
    while ($i < ($input.nums|count)) {
      each {
        // Get current house value
        var $current { value = $input.nums|slice:$i:($i + 1)|first }
        
        // dp[i] = max(dp[i-1], dp[i-2] + nums[i])
        var $option1 { value = $prev1 }
        var $option2 { value = $prev2 + $current }
        var $current_max { value = ($option1 >= $option2) ? $option1 : $option2 }
        
        // Update previous values
        var $prev2 { value = $prev1 }
        var $prev1 { value = $current_max }
        
        // Increment counter
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $prev1
}
