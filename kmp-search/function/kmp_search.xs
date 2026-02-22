function "kmp_search" {
  description = "Knuth-Morris-Pratt string pattern matching algorithm"
  input {
    text text
    text pattern
  }
  stack {
    // Handle edge cases
    conditional {
      if ($input.text == "" || $input.pattern == "") {
        return { value = [] }
      }
    }

    var $text_length { value = $input.text|strlen }
    var $pattern_length { value = $input.pattern|strlen }

    // If pattern is longer than text, no match possible
    conditional {
      if ($pattern_length > $text_length) {
        return { value = [] }
      }
    }

    // Build LPS (Longest Prefix Suffix) array
    var $lps { value = [] }
    
    // Initialize LPS array with zeros
    for ($pattern_length) {
      each as $i {
        var.update $lps { value = $lps|push:0 }
      }
    }

    // Compute LPS array
    var $len { value = 0 }
    var $i { value = 1 }

    while ($i < $pattern_length) {
      each {
        conditional {
          if (($input.pattern|substr:$i:1) == ($input.pattern|substr:$len:1)) {
            var.update $len { value = $len + 1 }
            var.update $lps { value = $lps|set:$i:$len }
            var.update $i { value = $i + 1 }
          }
          else {
            conditional {
              if ($len != 0) {
                var.update $len { value = $lps|get:($len - 1) }
              }
              else {
                var.update $lps { value = $lps|set:$i:0 }
                var.update $i { value = $i + 1 }
              }
            }
          }
        }
      }
    }

    // Perform KMP search
    var $matches { value = [] }
    var $text_index { value = 0 }
    var $pattern_index { value = 0 }

    while ($text_index < $text_length) {
      each {
        conditional {
          if (($input.pattern|substr:$pattern_index:1) == ($input.text|substr:$text_index:1)) {
            var.update $text_index { value = $text_index + 1 }
            var.update $pattern_index { value = $pattern_index + 1 }

            conditional {
              if ($pattern_index == $pattern_length) {
                // Found a match - record the starting position
                var $match_start { value = $text_index - $pattern_index }
                var.update $matches { value = $matches|push:$match_start }
                
                // Continue searching using LPS array
                var.update $pattern_index { value = $lps|get:($pattern_index - 1) }
              }
            }
          }
          else {
            conditional {
              if ($pattern_index != 0) {
                var.update $pattern_index { value = $lps|get:($pattern_index - 1) }
              }
              else {
                var.update $text_index { value = $text_index + 1 }
              }
            }
          }
        }
      }
    }
  }
  response = $matches
}
