function "combinations" {
  description = "Generate all combinations of k numbers out of 1..n"
  input {
    int n filters=min:1
    int k filters=min:0
  }
  stack {
    // Validate k <= n
    precondition ($input.k <= $input.n) {
      error_type = "inputerror"
      error = "k cannot be greater than n"
    }

    // Initialize result array
    var $result { value = [] }

    // Initialize current combination
    var $current { value = [] }

    // Recursive helper using iterative approach with a stack
    var $stack { value = [{start: 1, depth: 0}] }

    // Using while loop with explicit stack for backtracking
    while (($stack|count) > 0) {
      each {
        // Pop from stack
        var $frame { value = $stack|last }
        var $stack_copy { value = $stack|slice:0:-1 }
        var.update $stack { value = $stack_copy }

        var $start { value = $frame|get:"start":1 }
        var $depth { value = $frame|get:"depth":0 }

        conditional {
          if ($depth == $input.k) {
            // Found a complete combination, add to results
            var $combo_copy { value = $current|slice:0:$depth }
            var $result_with_combo {
              value = $result|merge:[$combo_copy]
            }
            var.update $result { value = $result_with_combo }
          }
          else {
            // Need to add more elements
            // Calculate how many elements we still need
            var $remaining { value = $input.k - $depth }
            var $max_start { value = $input.n - $remaining + 1 }

            // Push candidates in reverse order so smaller numbers are processed first
            var $i { value = $max_start }
            while ($i >= $start) {
              each {
                // Add current number to combination at current depth
                var $current_with_i {
                  value = $current|set:($depth|to_text):$i
                }
                var.update $current { value = $current_with_i }

                // Push next frame onto stack
                var $next_frame { value = {start: $i + 1, depth: $depth + 1} }
                var $stack_with_next {
                  value = $stack|merge:[$next_frame]
                }
                var.update $stack { value = $stack_with_next }

                math.add $i { value = -1 }
              }
            }
          }
        }
      }
    }
  }
  response = $result
}
