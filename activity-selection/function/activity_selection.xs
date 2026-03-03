// Activity Selection Problem - Classic Greedy Algorithm
// Given activities with start and end times, select maximum number of 
// non-overlapping activities that can be performed by a single person
function "activity_selection" {
  description = "Select maximum number of non-overlapping activities"
  
  input {
    object[] activities { 
      description = "Array of activities, each with 'start' and 'end' time (integers)" 
    }
  }
  
  stack {
    // Handle empty input
    conditional {
      if (`$input.activities|count == 0`) {
        return { value = [] }
      }
    }
    
    // Sort activities by end time (greedy choice)
    // We need to sort the array - use custom sort by end time
    var $sorted_activities { 
      value = $input.activities|sort:"end" 
    }
    
    // If sort filter doesn't work as expected, we'll need a different approach
    // For now, let's assume activities come pre-sorted or we use bubble sort
    
    // Alternative: Simple bubble sort implementation
    var $n { value = $input.activities|count }
    var $arr { value = $input.activities }
    var $i { value = 0 }
    
    while (`$i < $n - 1`) {
      each {
        var $j { value = 0 }
        while (`$j < $n - $i - 1`) {
          each {
            // Compare end times and swap if needed
            var $idx1 { value = $j }
            var $idx2 { value = $j + 1 }
            var $end1 { value = $arr[$idx1].end }
            var $end2 { value = $arr[$idx2].end }
            
            conditional {
              if (`$end1 > $end2`) {
                // Swap elements
                var $temp { value = $arr[$idx1] }
                var $arr { 
                  value = $arr|set:$idx1:$arr[$idx2]
                }
                var $arr { 
                  value = $arr|set:$idx2:$temp
                }
              }
            }
            
            var.update $j { value = $j + 1 }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Greedy selection
    var $selected { value = [] }
    var $last_end { value = -1 }
    var $idx { value = 0 }
    
    while (`$idx < $n`) {
      each {
        var $activity { value = $arr[$idx] }
        var $start_time { value = $activity.start }
        
        conditional {
          // If activity starts after or when the last one ends, select it
          if (`$start_time >= $last_end`) {
            var $selected { 
              value = $selected|merge:[$activity]
            }
            var $last_end { value = $activity.end }
          }
        }
        
        var.update $idx { value = $idx + 1 }
      }
    }
  }
  
  response = $selected
}
