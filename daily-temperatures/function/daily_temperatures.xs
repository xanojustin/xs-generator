// Daily Temperatures - Stack-based algorithm exercise
// For each day, find how many days until a warmer temperature
function "daily_temperatures" {
  description = "Given daily temperatures, returns days until warmer temp for each day"
  
  input {
    json temperatures { description = "Array of daily temperatures (integers)" }
  }
  
  stack {
    // Initialize result array with zeros (same length as input)
    var $temps { value = $input.temperatures|json_decode }
    var $n { value = $temps|count }
    var $result { value = [] }
    var $stack { value = [] }
    var $i { value = 0 }
    
    // Initialize result array with zeros
    while ($i < $n) {
      each {
        var $result { value = $result|merge:[0] }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Reset index for main algorithm
    var $i { value = 0 }
    
    // Use monotonic stack to find next warmer day
    // Stack stores indices of temperatures waiting for a warmer day
    while ($i < $n) {
      each {
        // While stack not empty and current temp > temp at stack top
        conditional {
          if (($stack|count) > 0) {
            // Peek at top of stack
            var $top_idx { value = $stack|last }
            var $top_temp { value = $temps[$top_idx] }
            var $curr_temp { value = $temps[$i] }
            
            conditional {
              if ($curr_temp > $top_temp) {
                // Found a warmer day for the index at stack top
                // Pop from stack
                var $stack { value = $stack|slice:0:-1 }
                var $days { value = $i - $top_idx }
                // Update result at top_idx position
                // Use slice to replace value at index
                var $before { value = $result|slice:0:$top_idx }
                var $after { value = $result|slice:($top_idx + 1) }
                var $result { value = ($before|merge:[$days])|merge:$after }
                // Continue checking stack (don't increment i yet)
                // Will be incremented at end of loop
                var $i { value = $i - 1 }
              }
            }
          }
        }
        
        // Push current index to stack
        var $stack { value = $stack|merge:[$i] }
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $result
}
