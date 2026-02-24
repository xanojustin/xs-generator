// Rotate String - Check if one string is a rotation of another
// Key insight: If s2 is a rotation of s1, then s2 must be a substring of s1 + s1
// Example: "abcde" rotated -> "cdeab". "abcde" + "abcde" = "abcdeabcde" contains "cdeab"
function "rotate_string" {
  description = "Checks if s2 is a rotation of s1"
  
  input {
    text s1 { description = "Original string" }
    text s2 { description = "String to check if it's a rotation of s1" }
  }
  
  stack {
    // Edge case: if lengths differ, s2 cannot be a rotation of s1
    conditional {
      if (($input.s1|strlen) != ($input.s2|strlen)) {
        return { value = false }
      }
    }
    
    // Edge case: empty strings are rotations of each other
    conditional {
      if (($input.s1|strlen) == 0) {
        return { value = true }
      }
    }
    
    // Concatenate s1 with itself
    var $concatenated { value = $input.s1 ~ $input.s1 }
    
    // Check if s2 is a substring of the concatenated string
    var $is_rotation { value = $concatenated|contains:$input.s2 }
  }
  
  response = $is_rotation
}