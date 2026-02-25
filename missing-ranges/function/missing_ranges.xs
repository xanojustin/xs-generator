// Missing Ranges - Classic coding exercise
// Given a sorted unique array of integers and a range [lower, upper],
// return the smallest sorted list of ranges that cover every missing number exactly
function "missing_ranges" {
  description = "Finds all missing ranges in a sorted unique array within [lower, upper] bounds"

  input {
    int[] nums { description = "Sorted unique array of integers" }
    int lower { description = "Lower bound of the range (inclusive)" }
    int upper { description = "Upper bound of the range (inclusive)" }
  }

  stack {
    var $result { value = [] }
    var $prev { value = $input.lower - 1 }
    var $i { value = 0 }

    // Iterate through nums plus a sentinel value (upper + 1)
    // This handles the case where the last number is less than upper
    while ($i <= ($input.nums|count)) {
      each {
        // Determine current value: either nums[i] or upper + 1 (sentinel)
        conditional {
          if ($i < ($input.nums|count)) {
            var $curr { value = $input.nums[$i] }
          }
          else {
            var $curr { value = $input.upper + 1 }
          }
        }

        // Check if there's a gap between prev and curr
        conditional {
          if ($curr - $prev >= 2) {
            // There are missing numbers between prev and curr
            var $range_start { value = $prev + 1 }
            var $range_end { value = $curr - 1 }

            conditional {
              if ($range_start == $range_end) {
                // Single number range
                var $range_str { value = $range_start|to_text }
              }
              else {
                // Multi-number range
                var $range_str { value = ($range_start|to_text) ~ "->" ~ ($range_end|to_text) }
              }
            }

            var $result {
              value = $result|merge:[$range_str]
            }
          }
        }

        var $prev { value = $curr }
        var.update $i { value = $i + 1 }
      }
    }
  }

  response = $result
}
