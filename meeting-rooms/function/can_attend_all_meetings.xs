// Meeting Rooms - Interval scheduling problem
// Determines if a person can attend all meetings without conflicts
function "can_attend_all_meetings" {
  description = "Determines if all meetings can be attended without conflicts"

  input {
    object[] intervals {
      description = "Array of meeting intervals, each with 'start' and 'end' times"
    }
  }

  stack {
    // Handle edge cases
    var $intervals_count { value = $input.intervals|count }

    conditional {
      // If 0 or 1 meetings, no conflicts possible
      if ($intervals_count <= 1) {
        var $can_attend { value = true }
      }
      else {
        // Create a copy of intervals for sorting
        var $sorted_intervals { value = $input.intervals }

        // Sort intervals by start time using bubble sort
        var $n { value = $intervals_count }
        var $sorted { value = false }

        while ($sorted == false) {
          each {
            var $i { value = 0 }
            var $swapped { value = false }

            while ($i < $n - 1) {
              each {
                var $current { value = $sorted_intervals[$i] }
                var $next { value = $sorted_intervals[$i + 1] }

                // Compare start times
                conditional {
                  if ($current.start > $next.start) {
                    // Swap the intervals
                    var $temp { value = $current }
                    var.update $sorted_intervals[$i] { value = $next }
                    var.update $sorted_intervals[$i + 1] { value = $temp }
                    var $swapped { value = true }
                  }
                }

                var.update $i { value = $i + 1 }
              }
            }

            var.update $n { value = $n - 1 }

            // If no swaps, array is sorted
            conditional {
              if ($swapped == false) {
                var $sorted { value = true }
              }
            }
          }
        }

        // Check for overlapping meetings
        var $j { value = 0 }
        var $has_conflict { value = false }

        while ($j < $intervals_count - 1) {
          each {
            var $current_meeting { value = $sorted_intervals[$j] }
            var $next_meeting { value = $sorted_intervals[$j + 1] }

            // Check if current meeting ends after next meeting starts
            conditional {
              if ($current_meeting.end > $next_meeting.start) {
                var $has_conflict { value = true }
              }
            }

            var.update $j { value = $j + 1 }
          }
        }

        conditional {
          if ($has_conflict == true) {
            var $can_attend { value = false }
          }
          else {
            var $can_attend { value = true }
          }
        }
      }
    }
  }

  response = $can_attend
}
