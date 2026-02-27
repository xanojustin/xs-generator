function "sort-characters-by-frequency" {
  description = "Sorts characters in a string by their frequency in descending order. If two characters have the same frequency, they are sorted alphabetically."

  input {
    text input_string { description = "The input string to sort characters by frequency" }
  }

  stack {
    // Handle empty string edge case
    conditional {
      if ($input.input_string == "") {
        var $result { value = "" }
      }
      else {
        // Split the string into individual characters
        var $chars { value = $input.input_string|split:"" }

        // Build a frequency map using index_by to group by character
        // This creates { "a": ["a", "a"], "b": ["b"], ... }
        var $grouped { value = $chars|index_by:$$ }

        // Transform the grouped object into an array of { char, count } objects
        // Use keys filter to get all character keys, then map to objects
        var $char_keys { value = $grouped|keys }
        var $frequencies { value = [] }

        foreach ($char_keys) {
          each as $char {
            var $count { value = ($grouped|get:$char)|count }
            var $entry { value = { char: $char, count: $count } }
            array.push $frequencies { value = $entry }
          }
        }

        // Sort by char ascending first (secondary sort for ties)
        var $sorted_by_char { value = $frequencies|sort:"char":"text":true }

        // Then sort by count descending (primary sort)
        var $sorted { value = $sorted_by_char|sort:"count":"int":false }

        // Build the result string by repeating each character count times
        var $result_chars { value = [] }

        foreach ($sorted) {
          each as $item {
            // Repeat character count times using a loop
            var $i { value = 0 }
            while ($i < $item.count) {
              each {
                array.push $result_chars { value = $item.char }
                var.update $i { value = $i + 1 }
              }
            }
          }
        }

        // Join all characters into final string
        var $result { value = $result_chars|join:"" }
      }
    }
  }

  response = $result
}
