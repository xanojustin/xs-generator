// Target Sum - Dynamic Programming Exercise
// Count ways to assign + or - to each number to reach target
// Uses memoization with a hash map for efficiency
function "target_sum" {
  description = "Count the number of ways to assign + or - to each number to reach target sum"
  
  input {
    int[] nums { description = "Array of integers to assign signs to" }
    int target { description = "Target sum to achieve" }
  }
  
  stack {
    // Calculate total sum of all numbers
    var $total { value = 0 }
    foreach ($input.nums) {
      each as $num {
        var $total { value = $total + $num }
      }
    }
    
    // Edge case: if target is impossible to achieve
    var $neg_total { value = 0 - $total }
    conditional {
      if ($input.target > $total || $input.target < $neg_total) {
        var $result { value = 0 }
      }
      else {
        // Use dynamic programming with offset to handle negative indices
        // dp[i][sum] = number of ways to achieve 'sum' using first i elements
        // We'll use a map where key is "index,sum" and value is count
        
        var $dp { value = {} }
        var $offset { value = $total }
        
        // Initialize: one way to achieve sum 0 with 0 elements
        var $initial_key { value = "0," ~ ($offset|to_text) }
        var $dp { value = $dp|set:$initial_key:1 }
        
        var $n { value = $input.nums|count }
        var $i { value = 0 }
        
        // Process each number
        while ($i < $n) {
          each {
            var $num { value = $input.nums[$i] }
            var $next_dp { value = {} }
            var $j { value = 0 - $total }
            
            // For each possible sum from previous step
            while ($j <= $total) {
              each {
                var $key { value = ($i|to_text) ~ "," ~ (($j + $offset)|to_text) }
                
                conditional {
                  if ($dp|has:$key) {
                    var $count { value = $dp|get:$key }
                    
                    // Add current number
                    var $new_sum_add { value = $j + $num }
                    var $new_key_add { value = (($i + 1)|to_text) ~ "," ~ (($new_sum_add + $offset)|to_text) }
                    var $existing_add { value = 0 }
                    conditional {
                      if ($next_dp|has:$new_key_add) {
                        var $existing_add { value = $next_dp|get:$new_key_add }
                      }
                    }
                    var $next_dp { value = $next_dp|set:$new_key_add:($existing_add + $count) }
                    
                    // Subtract current number
                    var $new_sum_sub { value = $j - $num }
                    var $new_key_sub { value = (($i + 1)|to_text) ~ "," ~ (($new_sum_sub + $offset)|to_text) }
                    var $existing_sub { value = 0 }
                    conditional {
                      if ($next_dp|has:$new_key_sub) {
                        var $existing_sub { value = $next_dp|get:$new_key_sub }
                      }
                    }
                    var $next_dp { value = $next_dp|set:$new_key_sub:($existing_sub + $count) }
                  }
                }
                
                var.update $j { value = $j + 1 }
              }
            }
            
            var $dp { value = $next_dp }
            var.update $i { value = $i + 1 }
          }
        }
        
        // Get result for target with all n elements
        var $result_key { value = ($n|to_text) ~ "," ~ (($input.target + $offset)|to_text) }
        var $result { value = 0 }
        conditional {
          if ($dp|has:$result_key) {
            var $result { value = $dp|get:$result_key }
          }
        }
      }
    }
  }
  
  response = $result
}
