// Count Binary Substrings - Count substrings with equal consecutive 0s and 1s
// For each adjacent group of consecutive 0s and 1s, count min(lengths)
function "count_binary_substrings" {
  description = "Counts binary substrings with equal consecutive 0s and 1s"
  
  input {
    text binary_string { description = "Binary string containing only 0s and 1s" }
  }
  
  stack {
    var $count { value = 0 }
    var $i { value = 1 }
    var $prev_length { value = 0 }
    var $curr_length { value = 1 }
    
    // Handle empty string or single character
    conditional {
      if (($input.binary_string|strlen) <= 1) {
        var $count { value = 0 }
      }
      else {
        // Iterate through the string starting from index 1
        while ($i < ($input.binary_string|strlen)) {
          each {
            conditional {
              // If current char equals previous char, increment current group length
              if (`$input.binary_string[$i] == $input.binary_string[$i - 1]`) {
                var $curr_length { value = $curr_length + 1 }
              }
              // If different, previous group ends, add min(prev, curr) to count
              else {
                var $count { value = $count + ($prev_length < $curr_length ? $prev_length : $curr_length) }
                var $prev_length { value = $curr_length }
                var $curr_length { value = 1 }
              }
            }
            var.update $i { value = $i + 1 }
          }
        }
        
        // Add the last group comparison
        var $count { value = $count + ($prev_length < $curr_length ? $prev_length : $curr_length) }
      }
    }
  }
  
  response = $count
}
