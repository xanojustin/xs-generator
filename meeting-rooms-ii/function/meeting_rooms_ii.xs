function "meeting_rooms_ii" {
  description = "Calculate minimum conference rooms required for given meeting intervals"
  input {
    json intervals { description = "Array of meeting intervals, each as [start, end]" }
  }
  stack {
    // Handle edge case: empty intervals
    conditional {
      if (($input.intervals|count) == 0) {
        return { value = 0 }
      }
    }
    
    // Extract start times and end times into separate arrays
    var $starts { value = [] }
    var $ends { value = [] }
    
    foreach ($input.intervals) {
      each as $interval {
        // Extract start time (first element)
        var $start { value = $interval|get:"0" }
        var $starts { value = $starts ~ [$start] }
        
        // Extract end time (second element)
        var $end { value = $interval|get:"1" }
        var $ends { value = $ends ~ [$end] }
      }
    }
    
    // Sort start times and end times
    var $sorted_starts { value = $starts|sort }
    var $sorted_ends { value = $ends|sort }
    
    // Use two-pointer technique to find max concurrent meetings
    var $rooms_needed { value = 0 }
    var $max_rooms { value = 0 }
    var $start_ptr { value = 0 }
    var $end_ptr { value = 0 }
    var $n { value = $sorted_starts|count }
    
    while (($start_ptr < $n) || ($end_ptr < $n)) {
      each {
        // If we've processed all starts, just end meetings
        conditional {
          if ($start_ptr >= $n) {
            math.add $end_ptr { value = 1 }
            math.add $rooms_needed { value = -1 }
          }
          else {
            // Get current start and end times
            var $curr_start { value = $sorted_starts[$start_ptr] }
            var $curr_end { value = $sorted_ends[$end_ptr] }
            
            // If current start is before or at current end, a meeting is starting
            conditional {
              if ($curr_start <= $curr_end) {
                math.add $rooms_needed { value = 1 }
                math.add $start_ptr { value = 1 }
                
                // Update max rooms if needed
                conditional {
                  if ($rooms_needed > $max_rooms) {
                    var $max_rooms { value = $rooms_needed }
                  }
                }
              }
              else {
                // A meeting is ending
                math.add $rooms_needed { value = -1 }
                math.add $end_ptr { value = 1 }
              }
            }
          }
        }
      }
    }
    
    var $result { value = $max_rooms }
  }
  response = $result
}
