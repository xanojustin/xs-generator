function "burst_balloons" {
  description = "Find maximum coins by bursting balloons optimally"
  input {
    int[] nums { description = "Array of balloon values" }
  }
  stack {
    // Handle empty array
    conditional {
      if (($input.nums|count) == 0) {
        return { value = 0 }
      }
    }

    // Create extended array with virtual balloons (value 1) at boundaries
    // extended = [1] + nums + [1]
    var $extended { value = [1] }
    
    foreach ($input.nums) {
      each as $num {
        var.update $extended { value = $extended|push:$num }
      }
    }
    var.update $extended { value = $extended|push:1 }
    
    var $n { value = ($extended|count) }
    
    // dp[i][j] = max coins from bursting all balloons between i and j (exclusive)
    // Initialize dp as 2D array of zeros
    var $dp { value = [] }
    
    for ($n) {
      each as $i {
        var $row { value = [] }
        for ($n) {
          each as $j {
            var.update $row { value = $row|push:0 }
          }
        }
        var.update $dp { value = $dp|push:$row }
      }
    }
    
    // Fill dp table
    // length is the gap between i and j
    var $length { value = 2 }
    
    while ($length < $n) {
      each {
        var $i { value = 0 }
        while (($i + $length) < $n) {
          each {
            var $j { value = $i + $length }
            var $max_coins { value = 0 }
            
            // Try bursting each balloon k between i and j last
            var $k { value = $i + 1 }
            while ($k < $j) {
              each {
                // coins = dp[i][k] + dp[k][j] + extended[i] * extended[k] * extended[j]
                var $left { value = $dp|get:$i|get:$k }
                var $right { value = $dp|get:$k|get:$j }
                var $burst { value = ($extended|get:$i) * ($extended|get:$k) * ($extended|get:$j) }
                var $total { value = $left + $right + $burst }
                
                conditional {
                  if ($total > $max_coins) {
                    var.update $max_coins { value = $total }
                  }
                }
                
                var.update $k { value = $k + 1 }
              }
            }
            
            // Update dp[i][j]
            var $row_i { value = $dp|get:$i }
            var.update $row_i { value = $row_i|set:$j:$max_coins }
            var.update $dp { value = $dp|set:$i:$row_i }
            
            var.update $i { value = $i + 1 }
          }
        }
        var.update $length { value = $length + 1 }
      }
    }
    
    // Result is dp[0][n-1]
    var $result { value = $dp|get:0|get:($n - 1) }
  }
  response = $result
}
