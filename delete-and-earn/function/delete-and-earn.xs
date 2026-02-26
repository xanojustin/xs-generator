// Delete and Earn - Dynamic programming exercise
// Given an array of integers, delete elements to earn maximum points
// When you delete a number, you earn its value but must also delete all (num-1) and (num+1)
function "delete-and-earn" {
  description = "Calculate maximum points that can be earned by deleting numbers"
  
  input {
    int[] nums { description = "Array of integers representing available numbers" }
  }
  
  stack {
    // Handle edge case: empty array
    conditional {
      if (($input.nums|count) == 0) {
        return { value = 0 }
      }
    }
    
    // Step 1: Build frequency map and find max number
    var $freq { value = {} }
    var $max_num { value = 0 }
    
    foreach ($input.nums) {
      each as $num {
        // Update frequency for this number
        var $current_count { value = ($freq|get:($num|to_text):0) + 1 }
        var.update $freq { 
          value = $freq|set:($num|to_text):$current_count
        }
        
        // Track max number
        conditional {
          if ($num > $max_num) {
            var.update $max_num { value = $num }
          }
        }
      }
    }
    
    // Step 2: Build points array where points[i] = total points for number i
    // points[i] = i * frequency of i
    var $points { value = [] }
    var $i { value = 0 }
    
    while ($i <= $max_num) {
      each {
        var $i_str { value = $i|to_text }
        var $count { value = $freq|get:$i_str:0 }
        var $point_value { value = $i * $count }
        var.update $points {
          value = $points|merge:[$point_value]
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Step 3: Apply House Robber DP logic
    // dp[i] = max(dp[i-1], dp[i-2] + points[i])
    // Can't take adjacent numbers (if we take i, we can't take i-1)
    
    conditional {
      // If max_num is 0, just return points[0]
      if ($max_num == 0) {
        return { value = $points|first }
      }
    }
    
    var $prev2 { value = $points|first }
    var $prev1 { value = ($points|slice:0:1|first) >= ($points|slice:1:2|first) ? ($points|slice:0:1|first) : ($points|slice:1:2|first) }
    
    var $j { value = 2 }
    while ($j <= $max_num) {
      each {
        var $current_points { value = $points|slice:$j:($j + 1)|first }
        var $option1 { value = $prev1 }
        var $option2 { value = $prev2 + $current_points }
        var $current_max { value = ($option1 >= $option2) ? $option1 : $option2 }
        
        var.update $prev2 { value = $prev1 }
        var.update $prev1 { value = $current_max }
        var.update $j { value = $j + 1 }
      }
    }
  }
  
  response = $prev1
}
