function "degree_of_array" {
  description = "Find the smallest subarray length with the same degree as the input array"
  input {
    int[] nums { description = "Array of non-negative integers" }
  }
  stack {
    // Edge case: empty array
    conditional {
      if (($input.nums|count) == 0) {
        return { value = 0 }
      }
    }

    // Hash maps to track frequency, first occurrence, and last occurrence
    var $frequency { value = {} }
    var $first_occurrence { value = {} }
    var $last_occurrence { value = {} }
    var $array_degree { value = 0 }
    var $index { value = 0 }

    // First pass: calculate frequencies and track occurrences
    foreach ($input.nums) {
      each as $num {
        // Update frequency
        var $current_freq {
          value = $frequency|get:($num|to_text):0
        }
        var.update $current_freq {
          value = $current_freq + 1
        }
        var.update $frequency {
          value = $frequency|set:($num|to_text):$current_freq
        }

        // Track first occurrence
        conditional {
          if ($current_freq == 1) {
            var.update $first_occurrence {
              value = $first_occurrence|set:($num|to_text):$index
            }
          }
        }

        // Always update last occurrence
        var.update $last_occurrence {
          value = $last_occurrence|set:($num|to_text):$index
        }

        // Update array degree
        conditional {
          if ($current_freq > $array_degree) {
            var.update $array_degree {
              value = $current_freq
            }
          }
        }

        // Increment index
        var.update $index {
          value = $index + 1
        }
      }
    }

    // Edge case: if degree is 1, smallest subarray is just 1 element
    conditional {
      if ($array_degree == 1) {
        return { value = 1 }
      }
    }

    // Second pass: find minimum length for elements with degree equal to array degree
    var $min_length { value = $input.nums|count }
    var $num_keys { value = $frequency|keys }

    foreach ($num_keys) {
      each as $key {
        var $freq {
          value = $frequency|get:$key:0
        }

        conditional {
          if ($freq == $array_degree) {
            var $first {
              value = $first_occurrence|get:$key:0
            }
            var $last {
              value = $last_occurrence|get:$key:0
            }
            var $subarray_length {
              value = $last - $first + 1
            }

            conditional {
              if ($subarray_length < $min_length) {
                var.update $min_length {
                  value = $subarray_length
                }
              }
            }
          }
        }
      }
    }
  }
  response = $min_length
}
