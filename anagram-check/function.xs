function "anagram_check" {
  description = "Check if two strings are anagrams of each other"
  input {
    text str1 filters=trim {
      description = "First string to compare"
    }
    text str2 filters=trim {
      description = "Second string to compare"
    }
  }
  stack {
    // Convert both strings to lowercase for case-insensitive comparison
    var $lower1 {
      value = $input.str1|to_lower
    }
    var $lower2 {
      value = $input.str2|to_lower
    }

    // Remove non-alphanumeric characters
    var $clean1 {
      value = "/[^a-z0-9]/"|regex_replace:"":$lower1
    }
    var $clean2 {
      value = "/[^a-z0-9]/"|regex_replace:"":$lower2
    }

    // If lengths differ after cleaning, they can't be anagrams
    conditional {
      if (($clean1|strlen) != ($clean2|strlen)) {
        var $result { value = false }
      }
      else {
        // Split into character arrays, sort them, then compare
        var $chars1 {
          value = $clean1|split:""|sort
        }
        var $chars2 {
          value = $clean2|split:""|sort
        }
        var $sorted1 {
          value = $chars1|join:""
        }
        var $sorted2 {
          value = $chars2|join:""
        }

        conditional {
          if ($sorted1 == $sorted2) {
            var $result { value = true }
          }
          else {
            var $result { value = false }
          }
        }
      }
    }
  }
  response = $result
}
