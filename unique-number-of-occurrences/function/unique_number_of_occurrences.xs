// Unique Number of Occurrences
// Given an array of integers, return true if the number of occurrences
// of each value in the array is unique, false otherwise
function "unique_number_of_occurrences" {
  description = "Checks if all element frequencies in the array are unique"

  input {
    int[] arr { description = "Array of integers to analyze" }
  }

  stack {
    // Build frequency map using an object
    var $frequency_map { value = {} }

    // Count occurrences of each number using foreach loop
    foreach ($input.arr) {
      each as $num {
        var $num_key { value = $num|to_text }
        conditional {
          if ($frequency_map|has:$num_key) {
            var $current_count { value = ($frequency_map|get:$num_key) + 1 }
            var.update $frequency_map { value = $frequency_map|set:$num_key:$current_count }
          }
          else {
            var.update $frequency_map { value = $frequency_map|set:$num_key:1 }
          }
        }
      }
    }

    // Extract all frequency values
    var $frequencies { value = $frequency_map|values }

    // Check if all frequencies are unique by comparing count vs unique count
    var $unique_frequencies { value = $frequencies|unique }
    var $all_unique { value = ($frequencies|count) == ($unique_frequencies|count) }
  }

  response = $all_unique
}
