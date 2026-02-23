function "strstr" {
  description = "Find the first occurrence of needle in haystack"
  input {
    text haystack { description = "The string to search within" }
    text needle { description = "The substring to find" }
  }
  stack {
    // Edge case: empty needle returns 0 (standard strstr behavior)
    conditional {
      if ($input.needle == "") {
        return { value = 0 }
      }
    }

    // Get lengths
    var $haystack_len { value = $input.haystack|strlen }
    var $needle_len { value = $input.needle|strlen }

    // Edge case: needle longer than haystack
    conditional {
      if ($needle_len > $haystack_len) {
        return { value = -1 }
      }
    }

    // Calculate max starting index to check
    var $max_start { value = $haystack_len - $needle_len }

    // Iterate through each possible starting position
    var $i { value = 0 }
    while ($i <= $max_start) {
      each {
        // Extract substring of same length as needle
        var $substring { value = $input.haystack|substr:$i:$needle_len }

        // Check if it matches
        conditional {
          if ($substring == $input.needle) {
            return { value = $i }
          }
        }

        // Move to next position
        var.update $i { value = $i + 1 }
      }
    }

    // Needle not found
    return { value = -1 }
  }
  response = $response
}
