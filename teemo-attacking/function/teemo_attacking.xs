// Teemo Attacking - Calculate total poison duration
// In the game League of Legends, Teemo attacks an enemy with poison.
// Each attack poisons the enemy for a given duration.
// If Teemo attacks again before the poison ends, the duration resets.
function "teemo_attacking" {
  description = "Calculate total time enemy is poisoned"
  
  input {
    int[] time_series { description = "Array of times when Teemo attacks" }
    int duration { description = "How long poison lasts after each attack (in seconds)" }
  }
  
  stack {
    // Handle empty time series case
    conditional {
      if (($input.time_series|count) == 0) {
        var $total_poison { value = 0 }
      }
      else {
        var $total_poison { value = 0 }
        var $i { value = 0 }
        
        while ($i < ($input.time_series|count)) {
          each {
            // Get current attack time
            var $current_time { value = $input.time_series[$i] }
            
            // Calculate when this poison would end
            var $current_end { value = $current_time + $input.duration }
            
            // Check if there's a next attack
            var $next_index { value = $i + 1 }
            
            conditional {
              if ($next_index < ($input.time_series|count)) {
                // Get next attack time
                var $next_time { value = $input.time_series[$next_index] }
                
                // If next attack happens before current poison ends,
                // only count time until next attack (poison gets reset)
                conditional {
                  if ($next_time < $current_end) {
                    var $poison_duration { value = $next_time - $current_time }
                  }
                  else {
                    // Full poison duration applies
                    var $poison_duration { value = $input.duration }
                  }
                }
              }
              else {
                // Last attack - full duration applies
                var $poison_duration { value = $input.duration }
              }
            }
            
            // Add to total
            var $total_poison { value = $total_poison + $poison_duration }
            
            // Increment counter
            var.update $i { value = $i + 1 }
          }
        }
      }
    }
  }
  
  response = $total_poison
}
