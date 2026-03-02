function "robot_bounded_in_circle" {
  description = "Determine if a robot is bounded in a circle after executing instructions"
  input {
    text instructions { description = "String of instructions: G=go, L=turn left, R=turn right" }
  }
  stack {
    // Direction vectors: North, East, South, West
    // 0 = North (0, 1), 1 = East (1, 0), 2 = South (0, -1), 3 = West (-1, 0)
    var $x { value = 0 }
    var $y { value = 0 }
    var $direction { value = 0 }
    
    // Convert instructions string to array of characters for iteration
    var $chars { value = $input.instructions|split:"" }
    
    foreach ($chars) {
      each as $char {
        conditional {
          if ($char == "G") {
            // Move in current direction
            conditional {
              if ($direction == 0) {
                // North: y + 1
                var.update $y { value = $y + 1 }
              }
              elseif ($direction == 1) {
                // East: x + 1
                var.update $x { value = $x + 1 }
              }
              elseif ($direction == 2) {
                // South: y - 1
                var.update $y { value = $y - 1 }
              }
              else {
                // West: x - 1
                var.update $x { value = $x - 1 }
              }
            }
          }
          elseif ($char == "L") {
            // Turn left: direction = (direction + 3) % 4
            var.update $direction { value = ($direction + 3) % 4 }
          }
          elseif ($char == "R") {
            // Turn right: direction = (direction + 1) % 4
            var.update $direction { value = ($direction + 1) % 4 }
          }
        }
      }
    }
    
    // Robot is bounded if:
    // 1. It's back at origin (0, 0), OR
    // 2. It's not facing North (direction != 0)
    var $at_origin { value = $x == 0 && $y == 0 }
    var $facing_north { value = $direction == 0 }
    var $bounded { value = $at_origin || !$facing_north }
  }
  response = $bounded
}
