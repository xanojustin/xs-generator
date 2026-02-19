function "anagram-detection" {
  description = "Check if two strings are anagrams of each other"
  input {
    text str1 filters=trim|lower
    text str2 filters=trim|lower
  }
  stack {
    // Quick check: if lengths differ, they can't be anagrams
    conditional {
      if (($input.str1|strlen) != ($input.str2|strlen)) {
        return { value = false }
      }
    }

    // Empty strings are anagrams of each other
    conditional {
      if (($input.str1|strlen) == 0) {
        return { value = true }
      }
    }

    // Convert strings to arrays of characters
    var $chars1 { value = $input.str1|split:"" }
    var $chars2 { value = $input.str2|split:"" }

    // Sort both character arrays
    var $sorted1 { value = $chars1|sort }
    var $sorted2 { value = $chars2|sort }

    // Compare sorted arrays - if equal, they're anagrams
    var $is_anagram { value = ($sorted1|json_encode) == ($sorted2|json_encode) }
  }
  response = $is_anagram
}
