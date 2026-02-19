function "first_unique_character" {
  description = "Find the first non-repeating character in a string"
  input {
    text str filters=trim {
      description = "The input string to search"
    }
  }
  stack {
    // Handle empty string case
    conditional {
      if (($input.str|strlen) == 0) {
        var $result { value = null }
      }
      else {
        // Build a frequency map of characters
        var $char_count { value = {} }
        var $i { value = 0 }
        var $len { value = $input.str|strlen }
        
        // Count occurrences of each character
        while ($i < $len) {
          each {
            var $char { value = $input.str[$i] }
            var $current_count { value = ($char_count|get:$char:0) }
            var.update $char_count { value = $char_count|set:$char:($current_count + 1) }
            var.update $i { value = $i + 1 }
          }
        }
        
        // Find first character with count of 1
        var $j { value = 0 }
        var $found { value = null }
        
        while ($j < $len) {
          each {
            var $char { value = $input.str[$j] }
            var $count { value = $char_count|get:$char:0 }
            
            conditional {
              if ($count == 1) {
                var $found { value = $char }
                // Break out of loop by setting j to length
                var $j { value = $len }
              }
            }
            
            conditional {
              if ($found == null) {
                var.update $j { value = $j + 1 }
              }
            }
          }
        }
        
        var $result { value = $found }
      }
    }
  }
  response = $result
}
