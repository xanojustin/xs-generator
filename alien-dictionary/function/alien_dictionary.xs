function "alien_dictionary" {
  description = "Determine the order of characters in an alien language given a list of words sorted lexicographically"
  input {
    text[] words
  }
  stack {
    // Handle edge cases
    conditional {
      if (($input.words|count) == 0) {
        return { value = "" }
      }
    }

    conditional {
      if (($input.words|count) == 1) {
        // Return unique characters in order of appearance
        var $unique_chars { value = [] }
        var $seen { value = {} }
        foreach ($input.words|first|split:"") {
          each as $char {
            conditional {
              if (!($seen|has:$char)) {
                var.update $unique_chars { value = $unique_chars|push:$char }
                var.update $seen { value = $seen|set:$char:true }
              }
            }
          }
        }
        return { value = $unique_chars|join:"" }
      }
    }

    // Build adjacency list and in-degree map
    var $adj { value = {} }
    var $in_degree { value = {} }
    var $all_chars { value = {} }

    // Initialize all characters
    foreach ($input.words) {
      each as $word {
        foreach ($word|split:"") {
          each as $char {
            var.update $all_chars { value = $all_chars|set:$char:true }
            conditional {
              if (!($adj|has:$char)) {
                var.update $adj { value = $adj|set:$char:[] }
              }
            }
            conditional {
              if (!($in_degree|has:$char)) {
                var.update $in_degree { value = $in_degree|set:$char:0 }
              }
            }
          }
        }
      }
    }

    // Build graph by comparing adjacent words
    var $i { value = 0 }
    while ($i < (($input.words|count) - 1)) {
      each {
        var $word1 { value = $input.words[$i] }
        var $word2 { value = $input.words[$i + 1] }
        var $j { value = 0 }
        var $found_diff { value = false }
        var $min_len {
          value = (($word1|strlen) < ($word2|strlen)) ? ($word1|strlen) : ($word2|strlen)
        }

        // Compare characters
        while (($j < $min_len) && !$found_diff) {
          each {
            // Get characters at position j using substring
            var $c1 { value = $word1|substr:$j:($j + 1) }
            var $c2 { value = $word2|substr:$j:($j + 1) }
            conditional {
              if ($c1 != $c2) {
                // Add edge c1 -> c2 if not already present
                var $neighbors { value = $adj|get:$c1:[] }
                conditional {
                  if (!($neighbors|contains:$c2)) {
                    var.update $neighbors { value = $neighbors|push:$c2 }
                    var.update $adj { value = $adj|set:$c1:$neighbors }
                    var $current_degree { value = $in_degree|get:$c2:0 }
                    var.update $in_degree { value = $in_degree|set:$c2:($current_degree + 1) }
                  }
                }
                var $found_diff { value = true }
              }
            }
            var $j { value = $j + 1 }
          }
        }
        var $i { value = $i + 1 }
      }
    }

    // Kahn's algorithm for topological sort
    var $queue { value = [] }
    var $result { value = [] }

    // Find all nodes with in-degree 0
    foreach ($in_degree|keys) {
      each as $char {
        conditional {
          if (($in_degree|get:$char:0) == 0) {
            var.update $queue { value = $queue|push:$char }
          }
        }
      }
    }

    // Process queue
    while (($queue|count) > 0) {
      each {
        var $char { value = $queue|first }
        var.update $queue { value = $queue|slice:1 }
        var.update $result { value = $result|push:$char }

        var $neighbors { value = $adj|get:$char:[] }
        foreach ($neighbors) {
          each as $neighbor {
            var $current_degree { value = $in_degree|get:$neighbor:0 }
            var.update $in_degree { value = $in_degree|set:$neighbor:($current_degree - 1) }
            conditional {
              if (($in_degree|get:$neighbor:0) == 0) {
                var.update $queue { value = $queue|push:$neighbor }
              }
            }
          }
        }
      }
    }

    // Check for cycles (invalid input)
    var $final_result { value = "" }
    conditional {
      if (($result|count) == ($all_chars|keys|count)) {
        var $final_result { value = $result|join:"" }
      }
    }
  }
  response = $final_result
}
