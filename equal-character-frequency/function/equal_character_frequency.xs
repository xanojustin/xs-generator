function "equal_character_frequency" {
  description = "Check if all characters in a string have equal number of occurrences"
  input {
    text s
  }
  stack {
    // Edge case: empty string is considered to have equal frequency
    conditional {
      if (($input.s|strlen) == 0) {
        return { value = true }
      }
    }
    
    // Create a frequency map using an object
    var $freq { value = {} }
    
    // Iterate through each character and count occurrences
    foreach ($input.s|split:"") {
      each as $char {
        conditional {
          if ($freq|has:$char) {
            // Increment existing count
            var $current_count { value = $freq|get:$char }
            var $new_count { value = $current_count + 1 }
            var.update $freq { value = $freq|set:$char:$new_count }
          }
          else {
            // Initialize count to 1
            var.update $freq { value = $freq|set:$char:1 }
          }
        }
      }
    }
    
    // Get all frequency values
    var $freq_values { value = $freq|values }
    
    // Get the first frequency as reference
    var $first_freq { value = $freq_values|first }
    
    // Check if all frequencies are equal to the first
    var $all_equal { value = true }
    
    foreach ($freq_values) {
      each as $freq_val {
        conditional {
          if ($freq_val != $first_freq) {
            var.update $all_equal { value = false }
          }
        }
      }
    }
  }
  response = $all_equal
}
