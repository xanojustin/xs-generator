function "climbing_stairs" {
  description = "Calculate the number of distinct ways to climb n stairs, taking 1 or 2 steps at a time"
  input {
    int n filters=min:0 { description = "The number of steps to reach the top" }
  }
  stack {
    // Edge cases: 0 or 1 step
    conditional {
      if ($input.n <= 1) {
        return { value = 1 }
      }
    }

    // Use dynamic programming - ways[i] = ways[i-1] + ways[i-2]
    // We only need to track the previous two values
    // prev2 = ways to climb 0 steps, prev1 = ways to climb 1 step
    var $prev2 { value = 1 }
    var $prev1 { value = 1 }
    var $current { value = 0 }

    var $i { value = 2 }
    while ($i <= $input.n) {
      each {
        // Current ways = ways from 1 step back + ways from 2 steps back
        var.update $current { value = $prev1 + $prev2 }
        
        // Shift the window
        var.update $prev2 { value = $prev1 }
        var.update $prev1 { value = $current }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  response = $prev1
}
