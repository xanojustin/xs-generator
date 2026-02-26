function "prison_cells" {
  description = "Calculate prison cell states after N days"
  input {
    int[] cells
    int n filters=min:0
  }
  stack {
    // Handle edge case: no days to simulate
    conditional {
      if ($input.n == 0) {
        return { value = $input.cells }
      }
    }

    // Initialize current state from input
    var $current { value = $input.cells }
    
    // Track seen states to detect cycles (encode state as text for key)
    var $seen { value = {} }
    var $day { value = 0 }
    var $has_cycle { value = false }
    var $cycle_start { value = 0 }
    var $cycle_length { value = 0 }

    while ($day < $input.n && !$has_cycle) {
      each {
        // Encode current state as text for cycle detection
        var $state_key { value = $current|json_encode }
        var $prev_day { value = $seen|get:$state_key:-1 }
        
        conditional {
          if ($prev_day != -1) {
            // Found a cycle
            var.update $has_cycle { value = true }
            var.update $cycle_start { value = $prev_day }
            var.update $cycle_length { value = $day - $prev_day }
          }
        }
        
        conditional {
          if (!$has_cycle) {
            // Record this state
            var.update $seen { value = $seen|set:$state_key:$day }
            
            // Calculate next state
            // New cell i is 1 if both neighbors are same (both 0 or both 1)
            // First and last cells (0 and 7) always become 0
            var $next { value = [0, 0, 0, 0, 0, 0, 0, 0] }
            var $j { value = 1 }
            
            while ($j < 7) {
              each {
                // Get neighbors
                var $left { value = $current[$j - 1] }
                var $right { value = $current[$j + 1] }
                
                conditional {
                  if ($left == $right) {
                    var.update $next { value = $next|set:$j:1 }
                  }
                }
                var.update $j { value = $j + 1 }
              }
            }
            
            var.update $current { value = $next }
            var.update $day { value = $day + 1 }
          }
        }
      }
    }

    // If we found a cycle, fast-forward through it
    conditional {
      if ($has_cycle) {
        var $remaining { value = $input.n - $day }
        var $skip_cycles { value = $remaining % $cycle_length }
        var $k { value = 0 }
        
        while ($k < $skip_cycles) {
          each {
            // Calculate next state
            var $next { value = [0, 0, 0, 0, 0, 0, 0, 0] }
            var $j { value = 1 }
            
            while ($j < 7) {
              each {
                var $left { value = $current[$j - 1] }
                var $right { value = $current[$j + 1] }
                
                conditional {
                  if ($left == $right) {
                    var.update $next { value = $next|set:$j:1 }
                  }
                }
                var.update $j { value = $j + 1 }
              }
            }
            
            var.update $current { value = $next }
            var.update $k { value = $k + 1 }
          }
        }
      }
    }
  }
  response = $current
}
