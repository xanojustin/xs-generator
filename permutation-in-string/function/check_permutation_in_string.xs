function "check_permutation_in_string" {
  description = "Check if s2 contains any permutation of s1 using sliding window with character frequency counting"
  input {
    text s1 { description = "Pattern string to find permutation of" }
    text s2 { description = "String to search within" }
  }
  stack {
    // Edge case: if s1 is longer than s2, impossible to contain permutation
    conditional {
      if (($input.s1|strlen) > ($input.s2|strlen)) {
        return { value = false }
      }
    }

    // Build frequency map for s1
    var $s1_freq {
      value = {}
    }
    foreach ($input.s1|split:"") {
      each as $char {
        conditional {
          if ($s1_freq|has:$char) {
            var $current_count {
              value = $s1_freq|get:$char
            }
            var.update $s1_freq {
              value = $s1_freq|set:$char:($current_count + 1)
            }
          }
          else {
            var.update $s1_freq {
              value = $s1_freq|set:$char:1
            }
          }
        }
      }
    }

    // Initialize window frequency map
    var $window_freq {
      value = {}
    }
    var $s1_len {
      value = $input.s1|strlen
    }
    var $s2_chars {
      value = $input.s2|split:""
    }

    // Build initial window of size s1_len
    var $i {
      value = 0
    }
    while ($i < $s1_len) {
      each {
        var $char {
          value = $s2_chars[$i]
        }
        conditional {
          if ($window_freq|has:$char) {
            var $current_count {
              value = $window_freq|get:$char
            }
            var.update $window_freq {
              value = $window_freq|set:$char:($current_count + 1)
            }
          }
          else {
            var.update $window_freq {
              value = $window_freq|set:$char:1
            }
          }
        }
        var.update $i {
          value = $i + 1
        }
      }
    }

    // Check if initial window matches
    var $matches {
      value = true
    }
    foreach ($s1_freq|keys) {
      each as $key {
        conditional {
          if (!($window_freq|has:$key)) {
            var.update $matches {
              value = false
            }
          }
          else {
            var $s1_count {
              value = $s1_freq|get:$key
            }
            var $window_count {
              value = $window_freq|get:$key
            }
            conditional {
              if ($s1_count != $window_count) {
                var.update $matches {
                  value = false
                }
              }
            }
          }
        }
      }
    }
    conditional {
      if ($matches == true) {
        return { value = true }
      }
    }

    // Slide the window through s2
    var $left {
      value = 0
    }
    var $right {
      value = $s1_len
    }
    var $s2_len {
      value = $input.s2|strlen
    }

    while ($right < $s2_len) {
      each {
        // Remove leftmost character from window
        var $left_char {
          value = $s2_chars[$left]
        }
        var $left_count {
          value = $window_freq|get:$left_char
        }
        var.update $window_freq {
          value = $window_freq|set:$left_char:($left_count - 1)
        }

        // Add new rightmost character to window
        var $right_char {
          value = $s2_chars[$right]
        }
        conditional {
          if ($window_freq|has:$right_char) {
            var $current_count {
              value = $window_freq|get:$right_char
            }
            var.update $window_freq {
              value = $window_freq|set:$right_char:($current_count + 1)
            }
          }
          else {
            var.update $window_freq {
              value = $window_freq|set:$right_char:1
            }
          }
        }

        // Move window
        var.update $left {
          value = $left + 1
        }
        var.update $right {
          value = $right + 1
        }

        // Check if current window matches s1 frequency
        var $window_matches {
          value = true
        }
        foreach ($s1_freq|keys) {
          each as $key {
            conditional {
              if (!($window_freq|has:$key)) {
                var.update $window_matches {
                  value = false
                }
              }
              else {
                var $s1_count {
                  value = $s1_freq|get:$key
                }
                var $win_count {
                  value = $window_freq|get:$key
                }
                conditional {
                  if ($s1_count != $win_count) {
                    var.update $window_matches {
                      value = false
                    }
                  }
                }
              }
            }
          }
        }
        conditional {
          if ($window_matches == true) {
            return { value = true }
          }
        }
      }
    }
  }
  response = false
}
