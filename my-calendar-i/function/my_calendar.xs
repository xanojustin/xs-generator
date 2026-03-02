// My Calendar I - Design exercise
// Implements a calendar that can book events without overlapping
function "my_calendar" {
  description = "Calendar that books events without double-booking"

  input {
    object[] bookings {
      description = "Array of booking attempts with start and end times"
    }
  }

  stack {
    // Store booked events as array of {start, end} objects
    var $booked_events { value = [] }
    var $results { value = [] }
    var $booking_index { value = 0 }

    // Process each booking attempt
    while ($booking_index < ($input.bookings|count)) {
      each {
        // Get current booking attempt
        var $current_booking {
          value = $input.bookings|get:$booking_index
        }
        var $start {
          value = $current_booking|get:"start"
        }
        var $end {
          value = $current_booking|get:"end"
        }

        // Check for overlap with existing events
        var $can_book { value = true }
        var $event_index { value = 0 }

        while ($event_index < ($booked_events|count) && $can_book == true) {
          each {
            var $existing {
              value = $booked_events|get:$event_index
            }
            var $existing_start {
              value = $existing|get:"start"
            }
            var $existing_end {
              value = $existing|get:"end"
            }

            // Check overlap: two events [s1, e1) and [s2, e2) overlap if s1 < e2 AND s2 < e1
            conditional {
              if ($start < $existing_end && $existing_start < $end) {
                var $can_book { value = false }
              }
            }

            var.update $event_index { value = $event_index + 1 }
          }
        }

        // If no overlap, add to booked events
        conditional {
          if ($can_book == true) {
            var $new_event {
              value = { start: $start, end: $end }
            }
            var $booked_events {
              value = $booked_events|merge:[$new_event]
            }
          }
        }

        // Add result for this booking attempt
        var $results {
          value = $results|merge:[$can_book]
        }

        var.update $booking_index { value = $booking_index + 1 }
      }
    }
  }

  response = $results
}
