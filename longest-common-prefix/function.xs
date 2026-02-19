function "longest_common_prefix" {
  description = "Find the longest common prefix among an array of strings"
  input {
    text[] strings {
      description = "Array of strings to find the common prefix from"
    }
  }
  stack {
    // Handle empty array case
    conditional {
      if (($input.strings|count) == 0) {
        var $result { value = "" }
      }
      elseif (($input.strings|count) == 1) {
        // Single string - the prefix is the string itself
        var $result { value = $input.strings|first }
      }
      else {
        // Start with the first string as the prefix candidate
        var $prefix { value = $input.strings|first }
        
        // Iterate through remaining strings
        var $i { value = 1 }
        
        while ($i < ($input.strings|count)) {
          each {
            var $current_string { value = $input.strings[$i] }
            
            // Reduce prefix until it matches the start of current string
            while (($prefix|strlen) > 0 && !(($current_string|starts_with:$prefix))) {
              each {
                var.update $prefix {
                  value = $prefix|substr:0:(($prefix|strlen) - 1)
                }
              }
            }
            
            // If prefix becomes empty, we can stop early
            conditional {
              if (($prefix|strlen) == 0) {
                // Exit outer loop early by setting i to count
                var.update $i { value = ($input.strings|count) }
              }
            }
            
            var.update $i { value = $i + 1 }
          }
        }
        
        var $result { value = $prefix }
      }
    }
  }
  response = $result
}
