// Maximum Bags With Full Capacity
// Given n bags with capacity and current rocks, and additional rocks,
// return the maximum number of bags that can be filled to full capacity
function "maximum_bags" {
  description = "Returns the maximum number of bags that can be filled to full capacity"
  
  input {
    int[] capacity { description = "Maximum capacity of each bag" }
    int[] rocks { description = "Current number of rocks in each bag" }
    int additionalRocks { description = "Number of additional rocks available" }
  }
  
  stack {
    // Calculate how many more rocks each bag needs
    var $needs { value = [] }
    var $i { value = 0 }
    
    foreach ($input.capacity) {
      each as $cap {
        var $current_rocks { value = $input.rocks[$i] }
        var $need { value = $cap - $current_rocks }
        var $needs {
          value = $needs|append:$need
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Sort needs using bubble sort (ascending)
    var $sorted_needs { value = $needs }
    var $n { value = $needs|count }
    var $swapped { value = true }
    
    while ($swapped) {
      each {
        var $swapped { value = false }
        var $j { value = 0 }
        
        while ($j < ($n - 1)) {
          each {
            var $current { value = $sorted_needs[$j] }
            var $next { value = $sorted_needs[($j + 1)] }
            
            conditional {
              if ($current > $next) {
                // Swap elements
                var $temp { value = $current }
                var $sorted_needs { value = $sorted_needs|set:$j:$next }
                var $sorted_needs { value = $sorted_needs|set:($j + 1):$temp }
                var $swapped { value = true }
              }
            }
            
            var.update $j { value = $j + 1 }
          }
        }
      }
    }
    
    // Greedily fill bags starting from those needing fewest rocks
    var $filled { value = 0 }
    var $remaining { value = $input.additionalRocks }
    
    foreach ($sorted_needs) {
      each as $need {
        conditional {
          if ($need <= $remaining) {
            var $remaining { value = $remaining - $need }
            var $filled { value = $filled + 1 }
          }
        }
      }
    }
  }
  
  response = $filled
}
