function "valid_anagram" {
  description = "Check if two strings are anagrams of each other"
  input {
    text s filters=trim|lower
    text t filters=trim|lower
  }
  stack {
    // If lengths differ, they cannot be anagrams
    conditional {
      if (($input.s|strlen) != ($input.t|strlen)) {
        return { value = false }
      }
    }

    // Convert strings to character arrays
    var $s_chars { value = $input.s|split:"" }
    var $t_chars { value = $input.t|split:"" }

    // Sort both arrays
    var $s_sorted { value = $s_chars|sort }
    var $t_sorted { value = $t_chars|sort }

    // Compare sorted arrays
    var $is_anagram { value = $s_sorted == $t_sorted }
  }
  response = $is_anagram
}
