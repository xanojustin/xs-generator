function "koko_eating_bananas" {
  description = "Find minimum eating speed K for Koko to eat all bananas within h hours"
  input {
    int[] piles
    int h
  }
  stack {
    // Handle edge cases
    conditional {
      if (($input.piles|count) == 0) {
        return { value = 0 }
      }
    }
    
    // Find max pile size (upper bound for binary search)
    var $max_pile { value = 0 }
    foreach ($input.piles) {
      each as $pile {
        conditional {
          if ($pile > $max_pile) {
            var.update $max_pile { value = $pile }
          }
        }
      }
    }
    
    // Binary search for minimum eating speed
    var $left { value = 1 }
    var $right { value = $max_pile }
    var $result { value = $max_pile }
    
    while ($left <= $right) {
      each {
        // Calculate mid point
        var $mid { value = ($left + $right) / 2 }
        
        // Calculate hours needed at speed $mid
        var $hours_needed { value = 0 }
        foreach ($input.piles) {
          each as $pile {
            // Hours for this pile = ceil(pile / mid)
            var $pile_hours { value = $pile / $mid }
            conditional {
              if ($pile % $mid > 0) {
                var.update $pile_hours { value = $pile_hours + 1 }
              }
            }
            var.update $hours_needed { value = $hours_needed + $pile_hours }
          }
        }
        
        // Check if we can eat all bananas within h hours
        conditional {
          if ($hours_needed <= $input.h) {
            // Can eat at this speed, try slower
            var.update $result { value = $mid }
            var.update $right { value = $mid - 1 }
          }
          else {
            // Cannot eat at this speed, need faster
            var.update $left { value = $mid + 1 }
          }
        }
      }
    }
  }
  response = $result
}
