function "max_russian_dolls" {
  description = "Find the maximum number of envelopes that can be Russian dolled (nested inside each other)"
  input {
    json envelopes
  }
  stack {
    // Handle edge case: empty input
    conditional {
      if (($input.envelopes|count) == 0) {
        return { value = 0 }
      }
    }

    // Convert each envelope array to an object for easier handling
    var $envelope_objects { value = [] }
    foreach ($input.envelopes) {
      each as $envelope {
        var $width { value = $envelope|get:0 }
        var $height { value = $envelope|get:1 }
        array.push $envelope_objects {
          value = { width: $width, height: $height }
        }
      }
    }

    // Sort envelopes by width ascending using bubble sort
    // (since XanoScript doesn't have a built-in sort statement)
    var $n { value = $envelope_objects|count }
    var $sorted { value = $envelope_objects }

    for ($n) {
      each as $i {
        var $inner_limit { value = $n - $i - 1 }
        conditional {
          if ($inner_limit > 0) {
            for ($inner_limit) {
              each as $j {
                var $idx { value = $j|to_int }
                var $current { value = $sorted|get:$idx }
                var $next_idx { value = $idx + 1 }
                var $next { value = $sorted|get:$next_idx }

                conditional {
                  if ($current.width > $next.width) {
                    // Swap elements
                    var $before { value = $sorted|slice:0:$idx }
                    var $after { value = $sorted|slice:($next_idx + 1):($n - $next_idx - 1) }
                    var $new_sorted { value = $before|merge:[$next]|merge:[$current]|merge:$after }
                    var.update $sorted { value = $new_sorted }
                  }
                }
              }
            }
          }
        }
      }
    }

    // Now extract heights and find LIS (Longest Increasing Subsequence)
    // We'll use the patience sorting / binary search approach
    // tails[i] = the smallest ending height of an increasing subsequence of length i+1
    var $tails { value = [] }

    foreach ($sorted) {
      each as $envelope {
        var $current_height { value = $envelope.height }
        var $tails_count { value = $tails|count }

        conditional {
          // If tails is empty, add current height
          if (($tails_count) == 0) {
            array.push $tails { value = $current_height }
          }
          // If current height is greater than all tails, append it
          elseif ($current_height > ($tails|last)) {
            array.push $tails { value = $current_height }
          }
          else {
            // Binary search to find the leftmost position where current_height should go
            var $left { value = 0 }
            var $right { value = ($tails_count - 1) }

            while ($left <= $right) {
              each {
                var $mid { value = (($left + $right) / 2)|to_int }
                var $mid_val { value = $tails|get:$mid }

                conditional {
                  if ($mid_val < $current_height) {
                    var.update $left { value = $mid + 1 }
                  }
                  else {
                    var.update $right { value = $mid - 1 }
                  }
                }
              }
            }

            // Replace at the found position
            var $new_tails { value = $tails|slice:0:$left }
            array.push $new_tails { value = $current_height }
            var $rest { value = $tails|slice:($left + 1):($tails_count - $left - 1) }
            array.merge $new_tails { value = $rest }
            var.update $tails { value = $new_tails }
          }
        }
      }
    }

    // The length of tails is the LIS length
    var $max_dolls { value = $tails|count }
  }
  response = $max_dolls
}
