function "plus_one" {
  description = "Add one to a number represented as an array of digits"
  
  input {
    int[] digits
  }
  
  stack {
    // Make a copy of the input array to avoid modifying it directly
    var $result { value = $input.digits }
    
    // Start from the last digit and work backwards
    var $carry { value = 1 }
    var $i { value = ($result|count) - 1 }
    
    while ($i >= 0 && $carry == 1) {
      each {
        // Get current digit
        var $current { value = $result|get:$i }
        
        // Add carry
        var $sum { value = $current + $carry }
        
        conditional {
          if ($sum >= 10) {
            // Set digit to sum % 10 and keep carry as 1
            var $new_digit { value = $sum - 10 }
            var.update $result { value = $result|set:$i:$new_digit }
            var $carry { value = 1 }
          }
          else {
            // No more carry needed
            var.update $result { value = $result|set:$i:$sum }
            var $carry { value = 0 }
          }
        }
        
        // Move to previous digit
        var.update $i { value = $i - 1 }
      }
    }
    
    // If we still have a carry after processing all digits,
    // we need to prepend a 1 (e.g., [9,9,9] -> [1,0,0,0])
    conditional {
      if ($carry == 1) {
        var $result { value = [1]|merge:$result }
      }
    }
  }
  
  response = $result
}
