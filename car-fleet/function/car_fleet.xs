function "car_fleet" {
  description = "Calculate the number of car fleets arriving at the destination"
  input {
    int target
    int[] position
    int[] speed
  }
  stack {
    // Validate inputs
    precondition ($input.target > 0) {
      error_type = "inputerror"
      error = "Target must be positive"
    }
    precondition (($input.position|count) == ($input.speed|count)) {
      error_type = "inputerror"
      error = "Position and speed arrays must have the same length"
    }
    
    // Handle edge case: no cars
    conditional {
      if (($input.position|count) == 0) {
        return { value = 0 }
      }
    }
    
    // Build array of cars with position and time to reach target
    var $cars { value = [] }
    var $idx { value = 0 }
    
    foreach ($input.position) {
      each as $pos {
        var $car_speed { value = $input.speed|get:$idx }
        var $distance { value = $input.target - $pos }
        var $time { value = ($distance|to_decimal) / ($car_speed|to_decimal) }
        var $car { value = { position: $pos, time: $time } }
        var.update $cars { value = $cars|push:$car }
        var.update $idx { value = $idx + 1 }
      }
    }
    
    // Sort cars by position descending (start from car closest to target)
    var $sorted_cars { value = $cars|sort:"position" }
    var $sorted_cars_desc { value = $sorted_cars|reverse }
    
    // Count fleets
    var $fleets { value = 0 }
    var $current_time { value = 0 }
    var $first { value = true }
    
    foreach ($sorted_cars_desc) {
      each as $car {
        conditional {
          if ($first) {
            var.update $fleets { value = 1 }
            var.update $current_time { value = $car.time }
            var.update $first { value = false }
          }
          elseif ($car.time > $current_time) {
            // This car forms a new fleet (slower than current fleet)
            var.update $fleets { value = $fleets + 1 }
            var.update $current_time { value = $car.time }
          }
        }
      }
    }
  }
  response = $fleets
}
