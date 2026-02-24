function "find_the_difference" {
  description = "Find the letter that was added to string t (which is a shuffled s plus one extra letter)"
  input {
    text s?
    text t
  }
  stack {
    // Handle empty s case - the added character is the only character in t
    conditional {
      if (($input.s|strlen) == 0) {
        var $result { value = $input.t|substr:0:1 }
        return { value = $result }
      }
    }

    // Build a frequency map for characters in s
    var $char_count { value = {} }
    var $s_length { value = $input.s|strlen }
    var $i { value = 0 }

    // Count characters in s
    while ($i < $s_length) {
      each {
        var $char { value = $input.s|substr:$i:1 }
        var $current_count {
          value = ($char_count|get:$char:0)|to_int
        }
        var.update $char_count {
          value = $char_count|set:$char:($current_count + 1)
        }
        var.update $i { value = $i + 1 }
      }
    }

    // Subtract characters in t
    var $t_length { value = $input.t|strlen }
    var.update $i { value = 0 }

    while ($i < $t_length) {
      each {
        var $char { value = $input.t|substr:$i:1 }
        var $current_count {
          value = ($char_count|get:$char:0)|to_int
        }
        var.update $char_count {
          value = $char_count|set:$char:($current_count - 1)
        }

        // If count goes negative, this is the extra character
        conditional {
          if (($current_count - 1) < 0) {
            var $result { value = $char }
            return { value = $result }
          }
        }

        var.update $i { value = $i + 1 }
      }
    }

    // Fallback - find any negative count (shouldn't reach here in valid inputs)
    var $result { value = $input.t|substr:0:1 }
  }
  response = $result
}
