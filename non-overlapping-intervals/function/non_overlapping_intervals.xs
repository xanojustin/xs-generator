// Non-overlapping Intervals - Greedy algorithm problem
// Given an array of intervals, return the minimum number of intervals
// to remove so that the remaining intervals don't overlap
function "non_overlapping_intervals" {
  description = "Find minimum intervals to remove for non-overlapping schedule"
  
  input {
    object[] intervals {
      description = "Array of intervals, each with start and end properties"
      schema {
        int start
        int end
      }
    }
  }
  
  stack {
    // Handle edge cases
    conditional {
      if (($input.intervals|count) <= 1) {
        return { value = 0 }
      }
    }
    
    // Sort intervals by end time (greedy approach)
    // We want to keep intervals that end earliest
    var $sorted_intervals {
      value = $input.intervals|sort:"end":"int":true
    }
    
    // Count of intervals to remove
    var $remove_count { value = 0 }
    
    // Track the end time of the last kept interval
    var $last_end {
      value = ($sorted_intervals|first).end
    }
    
    // Process remaining intervals
    var $i { value = 1 }
    var $n { value = $sorted_intervals|count }
    
    while ($i < $n) {
      each {
        var $current { value = $sorted_intervals[$i] }
        
        conditional {
          // If current interval starts before last kept interval ends, they overlap
          // We need to remove this interval
          if ($current.start < $last_end) {
            var.update $remove_count { value = $remove_count + 1 }
          }
          else {
            // No overlap - keep this interval and update last_end
            var.update $last_end { value = $current.end }
          }
        }
        
        math.add $i { value = 1 }
      }
    }
  }
  
  response = $remove_count
}
