// Happy Number - Classic math/algorithm exercise
// A happy number is a number which eventually reaches 1 when replaced by
// the sum of the square of each digit. If it loops endlessly in a cycle
// that does not include 1, it is an unhappy (sad) number.
function "is_happy_number" {
  description = "Determines if a given number is a happy number"
  
  input {
    int n { description = "The number to check (must be positive)" }
  }
  
  stack {
    // Use a set to track seen numbers and detect cycles
    var $seen { value = [] }
    var $current { value = $input.n }
    var $is_happy { value = false }
    
    // Edge case: 0 and negative numbers are not happy
    conditional {
      if ($input.n <= 0) {
        var $is_happy { value = false }
      }
      else {
        // Main loop - continue until we find 1 or detect a cycle
        while ($current != 1 && !($seen|contains:$current)) {
          each {
            // Add current number to seen set
            var $seen {
              value = $seen|merge:[$current]
            }
            
            // Calculate sum of squares of digits
            var $sum { value = 0 }
            var $temp { value = $current }
            
            while ($temp > 0) {
              each {
                var $digit { value = $temp % 10 }
                var $sum { value = $sum + ($digit * $digit) }
                var.update $temp { value = $temp / 10 }
              }
            }
            
            var.update $current { value = $sum }
          }
        }
        
        // Determine if happy (reached 1) or not (cycle detected)
        conditional {
          if ($current == 1) {
            var $is_happy { value = true }
          }
          else {
            var $is_happy { value = false }
          }
        }
      }
    }
  }
  
  response = $is_happy
}
