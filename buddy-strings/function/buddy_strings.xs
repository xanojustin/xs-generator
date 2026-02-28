// Buddy Strings - Check if two strings are "buddy strings"
// Two strings are buddy strings if you can swap exactly one pair of characters
// in one of them to make them equal
function "buddy_strings" {
  description = "Determines if two strings can be made equal by swapping exactly one pair of characters"
  
  input {
    text s filters=trim
    text goal filters=trim
  }
  
  stack {
    // If lengths differ, they cannot be buddy strings
    conditional {
      if (($input.s|strlen) != ($input_goal|strlen)) {
        return { value = false }
      }
    }
    
    // Find positions where characters differ
    var $diff_indices { value = [] }
    var $i { value = 0 }
    var $s_len { value = $input.s|strlen }
    
    while ($i < $s_len) {
      each {
        // Get characters at position $i
        var $s_char { value = $input.s|substr:$i:1 }
        var $goal_char { value = $input.goal|substr:$i:1 }
        
        conditional {
          if ($s_char != $goal_char) {
            var $diff_indices {
              value = $diff_indices|merge:[$i]
            }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
    
    var $diff_count { value = $diff_indices|count }
    
    // Case 1: No differences - need at least one duplicate character to swap
    conditional {
      if ($diff_count == 0) {
        // Check if there are any duplicate characters in s
        var $unique_chars { value = $input.s|split:""|unique }
        var $unique_count { value = $unique_chars|count }
        
        // If unique count is less than string length, there are duplicates
        return { value = ($unique_count < $s_len) }
      }
    }
    
    // Case 2: Exactly 2 differences - check if swapping would work
    conditional {
      if ($diff_count == 2) {
        var $first_diff { value = $diff_indices|first }
        var $second_diff { value = $diff_indices|last }
        
        // Get characters at differing positions
        var $s_first { value = $input.s|substr:$first_diff:1 }
        var $s_second { value = $input.s|substr:$second_diff:1 }
        var $goal_first { value = $input.goal|substr:$first_diff:1 }
        var $goal_second { value = $input.goal|substr:$second_diff:1 }
        
        // Check if swapping s's characters would match goal
        // s_first should equal goal_second and s_second should equal goal_first
        var $can_swap {
          value = ($s_first == $goal_second) && ($s_second == $goal_first)
        }
        
        return { value = $can_swap }
      }
    }
    
    // Any other number of differences - not buddy strings
    return { value = false }
  }
  
  response = $response
}
