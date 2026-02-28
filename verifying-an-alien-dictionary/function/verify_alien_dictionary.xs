function "verify_alien_dictionary" {
  description = "Check if words are sorted according to alien dictionary order"
  input {
    text[] words
    text order
  }
  stack {
    // Edge case: 0 or 1 word is always sorted
    conditional {
      if (($input.words|count) <= 1) {
        return { value = true }
      }
    }

    // Build character to index mapping from alien order
    var $char_map { value = {} }
    var $order_len { value = $input.order|strlen }
    var $i { value = 0 }

    while ($i < $order_len) {
      each {
        var $char { value = $input.order|substr:$i:1 }
        var.update $char_map { value = $char_map|set:$char:$i }
        var.update $i { value = $i + 1 }
      }
    }

    // Compare adjacent words
    var $word_count { value = $input.words|count }
    var $word_idx { value = 0 }
    var $is_sorted { value = true }

    while ($word_idx < ($word_count - 1)) {
      each {
        var $word1 { value = $input.words|get:$word_idx }
        var $word2 { value = $input.words|get:($word_idx + 1) }
        var $len1 { value = $word1|strlen }
        var $len2 { value = $word2|strlen }
        var $min_len { value = $len1 }

        conditional {
          if ($len2 < $len1) {
            var.update $min_len { value = $len2 }
          }
        }

        var $char_idx { value = 0 }
        var $order_determined { value = false }

        // Compare characters one by one
        while ($char_idx < $min_len) {
          each {
            conditional {
              if ($order_determined) {
                // Skip comparison - order already determined
              }
              else {
                var $c1 { value = $word1|substr:$char_idx:1 }
                var $c2 { value = $word2|substr:$char_idx:1 }
                var $idx1 { value = $char_map|get:$c1 }
                var $idx2 { value = $char_map|get:$c2 }

                conditional {
                  if ($idx1 < $idx2) {
                    // word1 < word2, they're sorted
                    var.update $order_determined { value = true }
                  }
                  elseif ($idx1 > $idx2) {
                    // word1 > word2, not sorted
                    var.update $order_determined { value = true }
                    var.update $is_sorted { value = false }
                  }
                }
              }
            }

            var.update $char_idx { value = $char_idx + 1 }
          }
        }

        // If no difference found in common prefix, check lengths
        conditional {
          if (!$order_determined && $len1 > $len2) {
            // "apple" > "app" - not sorted
            var.update $is_sorted { value = false }
          }
        }

        // If we found words out of order, stop checking
        conditional {
          if (!$is_sorted) {
            return { value = false }
          }
        }

        var.update $word_idx { value = $word_idx + 1 }
      }
    }
  }
  response = $is_sorted
}
