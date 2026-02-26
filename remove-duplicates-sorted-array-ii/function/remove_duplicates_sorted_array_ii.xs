function "remove_duplicates_sorted_array_ii" {
  description = "Remove duplicates from sorted array allowing at most 2 occurrences of each element"
  input {
    int[] nums
  }
  stack {
    // Create a working copy of the input array (since we can't modify $input directly)
    var $working_nums { value = $input.nums }

    // Handle edge cases
    conditional {
      if (($working_nums|count) <= 2) {
        return { value = { length: ($working_nums|count), array: $working_nums } }
      }
    }

    // Use two-pointer technique
    // i = position to place next valid element
    // Start from index 2 since we always keep first two elements
    var $i { value = 2 }

    // Iterate through array starting from index 2
    var $idx { value = 2 }
    while ($idx < ($working_nums|count)) {
      each {
        // Check if current element can be placed at position i
        // It can be placed if it's different from the element two positions back
        conditional {
          if ($working_nums[$idx] != $working_nums[$i - 2]) {
            // Place the element at position i
            var.update $working_nums[$i] { value = $working_nums[$idx] }
            // Increment i
            var.update $i { value = $i + 1 }
          }
        }
        // Move to next element
        var.update $idx { value = $idx + 1 }
      }
    }

    // Build result with the modified array (only up to length i)
    var $result_array { value = $working_nums|slice:0:$i }
  }
  response = { length: $i, array: $result_array }
}
