function "merge_intervals" {
  description = "Merge overlapping intervals into a consolidated list"
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
    // Handle empty input
    conditional {
      if (($input.intervals|count) == 0) {
        return { value = [] }
      }
    }

    // Sort intervals by start time
    var $sorted_intervals {
      value = $input.intervals|sort:"start":"int":true
    }

    // Initialize result with first interval
    var $merged {
      value = [$sorted_intervals|first]
    }

    // Process remaining intervals
    var $i { value = 1 }
    var $n { value = $sorted_intervals|count }

    while ($i < $n) {
      each {
        // Get current interval and last merged interval
        var $current { value = $sorted_intervals[$i] }
        var $last { value = $merged|last }

        // Check if current interval overlaps with last merged interval
        conditional {
          if ($current.start <= $last.end) {
            // Overlapping - merge by updating the end
            var $new_end {
              value = ($current.end > $last.end) ? $current.end : $last.end
            }
            // Update the last interval's end
            var $updated_last {
              value = $last|set:"end":$new_end
            }
            // Replace the last interval in merged array
            array.pop $merged as $popped
            array.push $merged {
              value = $updated_last
            }
          }
          else {
            // Non-overlapping - add as new interval
            array.push $merged {
              value = $current
            }
          }
        }

        math.add $i { value = 1 }
      }
    }
  }
  response = $merged
}
