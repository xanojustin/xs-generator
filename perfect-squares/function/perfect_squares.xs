function "perfect_squares" {
  description = "Given an integer n, return the least number of perfect square numbers that sum to n"
  input {
    int n filters=min:1 { description = "The target number to sum to" }
  }
  stack {
    // Initialize DP array - dp[i] = min number of perfect squares that sum to i
    // Use an array where index represents the number and value represents min squares needed
    var $dp { value = [] }
    
    // dp[0] = 0 (zero perfect squares sum to 0)
    var.update $dp { value = $dp|push:0 }
    
    // Initialize dp[i] = i (worst case: use i ones)
    var $i { value = 1 }
    while ($i <= $input.n) {
      each {
        var.update $dp { value = $dp|push:$i }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Dynamic programming: for each number from 1 to n
    // try all perfect squares less than or equal to it
    var $num { value = 1 }
    while ($num <= $input.n) {
      each {
        var $square_root { value = 1 }
        
        // Try all perfect squares j*j where j*j <= num
        while (($square_root * $square_root) <= $num) {
          each {
            var $square { value = $square_root * $square_root }
            var $remaining { value = $num - $square }
            
            // dp[num] = min(dp[num], dp[num - square] + 1)
            var $current_dp { value = $dp|get:$num:999999 }
            var $candidate { value = ($dp|get:$remaining:999999) + 1 }
            
            conditional {
              if ($candidate < $current_dp) {
                var $new_dp { value = [] }
                var $idx { value = 0 }
                foreach ($dp) {
                  each as $val {
                    conditional {
                      if ($idx == $num) {
                        var.update $new_dp { value = $new_dp|push:$candidate }
                      }
                      else {
                        var.update $new_dp { value = $new_dp|push:$val }
                      }
                    }
                    var.update $idx { value = $idx + 1 }
                  }
                }
                var $dp { value = $new_dp }
              }
            }
            
            var.update $square_root { value = $square_root + 1 }
          }
        }
        
        var.update $num { value = $num + 1 }
      }
    }
    
    var $result { value = $dp|get:$input.n:0 }
  }
  response = $result
}
