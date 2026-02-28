function "parking-system" {
  description = "Parking System - tracks available spots and parks cars"
  
  input {
    int big
    int medium
    int small
    int carType
  }
  
  stack {
    // Initialize available spots based on car type
    // carType 1 = big, 2 = medium, 3 = small
    
    conditional {
      if ($input.carType == 1) {
        // Big car - check if big spot available
        conditional {
          if ($input.big > 0) {
            var $can_park { value = true }
          }
          else {
            var $can_park { value = false }
          }
        }
      }
      elseif ($input.carType == 2) {
        // Medium car - check if medium spot available
        conditional {
          if ($input.medium > 0) {
            var $can_park { value = true }
          }
          else {
            var $can_park { value = false }
          }
        }
      }
      elseif ($input.carType == 3) {
        // Small car - check if small spot available
        conditional {
          if ($input.small > 0) {
            var $can_park { value = true }
          }
          else {
            var $can_park { value = false }
          }
        }
      }
      else {
        // Invalid car type
        var $can_park { value = false }
      }
    }
  }
  
  response = $can_park
}
