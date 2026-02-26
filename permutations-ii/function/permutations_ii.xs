// Permutations II - Generate all unique permutations
// Given a list of integers that may contain duplicates, return all unique permutations
function "permutations_ii" {
  description = "Generate all unique permutations of a list that may contain duplicates"

  input {
    int[] nums { description = "Array of integers (may contain duplicates)" }
  }

  stack {
    // Result array to store all unique permutations
    var $result { value = [] }

    // Sort the input to group duplicates together
    var $sorted_nums { value = $input.nums|sort }

    // Track which indices are used in current permutation
    var $used { value = {} }

    // Initialize used tracking object with all false
    var $i { value = 0 }
    while ($i < ($sorted_nums|count)) {
      each {
        var $used {
          value = $used|set:($i|to_text):false
        }
        var.update $i { value = $i + 1 }
      }
    }

    // Current permutation being built
    var $current { value = [] }

    // Backtracking using manual stack
    var $stack { value = [] }

    // Initialize with starting state
    var $stack {
      value = [
        {
          current: [],
          used: $used
        }
      ]
    }

    // While stack is not empty
    while (($stack|count) > 0) {
      each {
        // Pop from stack
        var $state { value = $stack|last }
        var $stack {
          value = $stack|slice:0:-1
        }

        var $curr_perm { value = $state|get:"current" }
        var $curr_used { value = $state|get:"used" }

        // If current permutation is complete
        conditional {
          if (($curr_perm|count) == ($sorted_nums|count)) {
            // Add to result
            var $result {
              value = $result|merge:[$curr_perm]
            }
          }
          else {
            // Try each number that hasn't been used
            var $idx { value = 0 }
            while ($idx < ($sorted_nums|count)) {
              each {
                var $idx_key { value = $idx|to_text }
                var $is_used { value = $curr_used|get:$idx_key }

                conditional {
                  if (!$is_used) {
                    // Check for duplicates: skip if previous identical element is unused
                    // This ensures we only use duplicates in order
                    var $should_skip { value = false }

                    conditional {
                      if ($idx > 0) {
                        var $prev_idx { value = $idx - 1 }
                        var $prev_idx_key { value = $prev_idx|to_text }
                        var $prev_used { value = $curr_used|get:$prev_idx_key }
                        var $curr_val { value = $sorted_nums[$idx] }
                        var $prev_val { value = $sorted_nums[$prev_idx] }

                        conditional {
                          if (($curr_val == $prev_val) && !$prev_used) {
                            var $should_skip { value = true }
                          }
                        }
                      }
                    }

                    conditional {
                      if (!$should_skip) {
                        // Create new state with current number added
                        var $new_perm {
                          value = $curr_perm|merge:[$sorted_nums[$idx]]
                        }
                        var $new_used {
                          value = $curr_used|set:$idx_key:true
                        }

                        // Push to stack
                        var $new_state {
                          value = {
                            current: $new_perm,
                            used: $new_used
                          }
                        }
                        var $stack {
                          value = $stack|merge:[$new_state]
                        }
                      }
                    }
                  }
                }

                var.update $idx { value = $idx + 1 }
              }
            }
          }
        }
      }
    }
  }

  response = $result
}
