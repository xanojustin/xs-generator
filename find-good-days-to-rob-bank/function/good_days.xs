function "good_days" {
  description = "Find good days to rob the bank based on security guard patterns"
  
  input {
    int[] security {
      description = "Array of guard counts for each day"
    }
    int time {
      description = "Number of days to check before and after each potential day"
    }
  }
  
  stack {
    // Get the number of days
    var $n { value = $input.security|count }
    
    // Initialize array to store good days
    var $good_days { value = [] }
    
    // Edge case: if array is too small, return empty
    conditional {
      if (($n) < (($input.time * 2) + 1)) {
        return { value = [] }
      }
    }
    
    // Iterate through each potential day
    // Day i is valid if: time <= i < n - time
    var $i { value = $input.time }
    
    while ($i < ($n - $input.time)) {
      each {
        // Check if days before are non-increasing (decreasing or equal)
        // i.e., security[i-time] >= security[i-time+1] >= ... >= security[i]
        var $is_good_before { value = true }
        var $j { value = $i - $input.time }
        
        while ($j < $i) {
          each {
            conditional {
              if ($input.security[$j] < $input.security[$j + 1]) {
                var $is_good_before { value = false }
              }
            }
            var.update $j { value = $j + 1 }
          }
        }
        
        // Check if days after are non-decreasing (increasing or equal)
        // i.e., security[i] <= security[i+1] <= ... <= security[i+time]
        var $is_good_after { value = true }
        var $k { value = $i }
        
        while ($k < ($i + $input.time)) {
          each {
            conditional {
              if ($input.security[$k] > $input.security[$k + 1]) {
                var $is_good_after { value = false }
              }
            }
            var.update $k { value = $k + 1 }
          }
        }
        
        // If both conditions are met, add to good days
        conditional {
          if ($is_good_before && $is_good_after) {
            var $good_days { value = $good_days ~ [$i] }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $good_days
}
