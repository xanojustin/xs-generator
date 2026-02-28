// Minimum Genetic Mutation - BFS coding exercise
// Find the minimum number of mutations needed to mutate from start gene to end gene
// A mutation is defined as one single character changed in the gene string
// Each intermediate gene must be in the bank
function "min_genetic_mutation" {
  description = "Finds minimum mutations from start gene to end gene using BFS"

  input {
    text start { description = "Starting gene string (8 chars: A, C, G, T)" }
    text end { description = "Target gene string (8 chars: A, C, G, T)" }
    text[] bank { description = "Array of valid gene strings" }
  }

  stack {
    var $result { value = -1 }

    // Edge case: if start equals end, no mutations needed
    conditional {
      if ($input.start == $input.end) {
        var $result { value = 0 }
      }
    }

    // Only proceed if result hasn't been set (start != end)
    conditional {
      if ($result == -1) {
        // Edge case: if bank is empty, impossible
        conditional {
          if (($input.bank|count) == 0) {
            var $result { value = -1 }
          }
        }
      }
    }

    // Only proceed if still possible
    conditional {
      if ($result == -1) {
        // Convert bank to a set-like object for O(1) lookup
        var $bank_set { value = {} }
        foreach ($input.bank) {
          each as $gene {
            var $bank_set {
              value = $bank_set|set:$gene:true
            }
          }
        }

        // Check if end gene is in bank
        conditional {
          if (!($bank_set|has:$input.end)) {
            var $result { value = -1 }
          }
        }

        // Only proceed if end is in bank
        conditional {
          if ($result == -1) {
            // BFS setup
            var $queue { value = [$input.start] }
            var $visited { value = {$input.start: true} }
            var $mutations { value = 0 }
            var $found { value = false }
            var $chars { value = ["A", "C", "G", "T"] }

            while ((($queue|count) > 0) && !$found) {
              each {
                var $mutations { value = $mutations + 1 }
                var $level_size { value = $queue|count }
                var $i { value = 0 }

                while (($i < $level_size) && !$found) {
                  each {
                    var $current { value = $queue|first }
                    var $queue { value = $queue|slice:1 }

                    // Try mutating each position
                    var $pos { value = 0 }
                    while (($pos < 8) && !$found) {
                      each {
                        foreach ($chars) {
                          each as $char {
                            conditional {
                              if (!$found) {
                                // Create mutation by replacing character at position
                                var $before { value = $current|slice:0:$pos }
                                var $after { value = $current|slice:($pos + 1):8 }
                                var $mutated { value = $before ~ $char ~ $after }

                                // Check if this mutation is the target
                                conditional {
                                  if ($mutated == $input.end) {
                                    var $found { value = true }
                                    var $result { value = $mutations }
                                  }
                                }

                                // Add to queue if valid and not visited
                                conditional {
                                  if ((!$found) && ($bank_set|has:$mutated) && (!($visited|has:$mutated))) {
                                    var $queue {
                                      value = $queue|merge:[$mutated]
                                    }
                                    var $visited {
                                      value = $visited|set:$mutated:true
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                        var.update $pos { value = $pos + 1 }
                      }
                    }
                    var.update $i { value = $i + 1 }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  response = $result
}
