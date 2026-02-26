function "asteroid_collision" {
  description = "Simulate asteroid collisions and return surviving asteroids"
  input {
    int[] asteroids { description = "Array of integers representing asteroids (positive = right, negative = left)" }
  }
  stack {
    // Use a stack to track surviving asteroids
    var $stack {
      value = []
    }

    // Process each asteroid
    foreach ($input.asteroids) {
      each as $asteroid {
        // Current asteroid being processed
        var $current {
          value = $asteroid
        }

        // Flag to track if current asteroid survives
        var $survives {
          value = true
        }

        // Check for collisions: current asteroid moving left (negative)
        // and top of stack moving right (positive)
        while ($survives && $current < 0 && (($stack|count) > 0) && (($stack|last) > 0)) {
          each {
            // Get the top asteroid from stack
            var $top {
              value = $stack|last
            }

            conditional {
              // Top asteroid is larger - current explodes
              if ($top > ($current|abs)) {
                var.update $survives { value = false }
              }
              // Both same size - both explode
              elseif ($top == ($current|abs)) {
                var.update $survives { value = false }
                // Remove top from stack
                var.update $stack { value = $stack|pop }
              }
              // Current asteroid is larger - top explodes
              else {
                // Remove top from stack (it explodes), continue checking
                var.update $stack { value = $stack|pop }
              }
            }
          }
        }

        // If current asteroid survives, add it to stack
        conditional {
          if ($survives) {
            var.update $stack { value = $stack|push:$current }
          }
        }
      }
    }
  }
  response = $stack
}
