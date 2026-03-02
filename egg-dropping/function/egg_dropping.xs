function "egg_dropping" {
  description = "Find the minimum number of attempts to find the critical floor with k eggs and n floors"
  input {
    int k filters=min:1 { description = "Number of eggs available" }
    int n filters=min:1 { description = "Number of floors in the building" }
  }
  stack {
    // Edge case: if we have 1 egg, we must check every floor linearly
    conditional {
      if ($input.k == 1) {
        return { value = $input.n }
      }
    }

    // Edge case: if we have 0 or 1 floor
    conditional {
      if ($input.n <= 1) {
        return { value = $input.n }
      }
    }

    // Use optimized DP: dp[m] = max floors we can check with m moves and current eggs
    // We iterate attempts until we can cover n floors
    
    var $attempts { value = 0 }
    
    // dp[i] = maximum floors we can check with i eggs and current number of attempts
    // Initialize all to 0
    var $dp { value = [] }
    for ($input.k + 1) {
      each as $i {
        var $dp { value = $dp|push:0 }
      }
    }

    // Keep increasing attempts until we can cover all n floors
    var $canCover { value = 0 }
    
    while ($canCover < $input.n) {
      each {
        var $attempts { value = $attempts + 1 }
      
      // Update dp from high to low egg counts
      // We need to work backwards to use values from previous iteration
      var $egg { value = $input.k }
      
      while ($egg >= 1) {
        each {
        // dp[egg] = dp[egg-1] (egg breaks) + dp[egg] (egg survives) + 1 (current floor)
        var $prevIdx { value = $egg - 1 }
        var $breakCase { value = $dp|get:("" ~ $prevIdx)|to_int }
        var $surviveCase { value = $dp|get:("" ~ $egg)|to_int }
        var $newVal { value = $breakCase + $surviveCase + 1 }
        
        // Create new dp array with updated value
        var $newDp { value = [] }
        var $idx { value = 0 }
        foreach ($dp) {
          each as $oldVal {
            conditional {
              if ($idx == $egg) {
                var $newDp { value = $newDp|push:$newVal }
              }
              else {
                var $newDp { value = $newDp|push:$oldVal }
              }
            }
            var $idx { value = $idx + 1 }
          }
        }
        var $dp { value = $newDp }
        var $egg { value = $egg - 1 }
        }
      }
      
      var $canCover { value = $dp|get:("" ~ $input.k)|to_int }
      }
    }
  }
  response = $attempts
}
