// Insert Interval - Classic coding exercise
// Given a set of non-overlapping intervals sorted by start time,
// insert a new interval and merge overlapping intervals if necessary
function "insert_interval" {
  description = "Insert a new interval into sorted non-overlapping intervals and merge if needed"
  
  input {
    object[] intervals {
      description = "Array of non-overlapping intervals sorted by start time, each with start and end properties"
      schema {
        int start
        int end
      }
    }
    object new_interval {
      description = "The new interval to insert with start and end properties"
      schema {
        int start
        int end
      }
    }
  }
  
  stack {
    // Handle empty intervals - just return the new interval
    conditional {
      if (($input.intervals|count) == 0) {
        return { value = [$input.new_interval] }
      }
    }
    
    var $result { value = [] }
    var $i { value = 0 }
    var $n { value = $input.intervals|count }
    var $new_start { value = $input.new_interval.start }
    var $new_end { value = $input.new_interval.end }
    
    // Add all intervals that come before the new interval (no overlap)
    while ($i < $n && $input.intervals[$i].end < $new_start) {
      each {
        array.push $result {
          value = $input.intervals[$i]
        }
        math.add $i { value = 1 }
      }
    }
    
    // Merge overlapping intervals with the new interval
    while ($i < $n && $input.intervals[$i].start <= $new_end) {
      each {
        // Update new interval to encompass the overlap
        var $merged_start {
          value = ($input.intervals[$i].start < $new_start) ? $input.intervals[$i].start : $new_start
        }
        var $merged_end {
          value = ($input.intervals[$i].end > $new_end) ? $input.intervals[$i].end : $new_end
        }
        var.update $new_start { value = $merged_start }
        var.update $new_end { value = $merged_end }
        math.add $i { value = 1 }
      }
    }
    
    // Add the merged new interval
    array.push $result {
      value = {start: $new_start, end: $new_end}
    }
    
    // Add all remaining intervals (after the new interval)
    while ($i < $n) {
      each {
        array.push $result {
          value = $input.intervals[$i]
        }
        math.add $i { value = 1 }
      }
    }
  }
  
  response = $result
}
