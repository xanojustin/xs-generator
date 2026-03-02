// Sum of Square Numbers - Check if c = a² + b² for some integers a, b
// Uses two-pointer technique for efficient O(√c) solution
function "sum_of_square_numbers" {
  description = "Determines if a non-negative integer c can be expressed as sum of two squares"
  
  input {
    int c { description = "Non-negative integer to check" }
  }
  
  stack {
    // Edge case: negative numbers cannot be expressed as sum of two squares
    conditional {
      if ($input.c < 0) {
        return { value = false }
      }
    }
    
    // Initialize two pointers
    // a starts at 0, b starts at sqrt(c)
    var $a { value = 0 }
    var $b { value = ($input.c|sqrt)|floor }
    var $found { value = false }
    
    // Two-pointer approach
    // If a² + b² == c: found it!
    // If a² + b² < c: need larger sum, increment a
    // If a² + b² > c: need smaller sum, decrement b
    while (($a <= $b) && ($found == false)) {
      each {
        var $sum_squares { value = ($a * $a) + ($b * $b) }
        
        conditional {
          if ($sum_squares == $input.c) {
            // Found a valid pair (a, b)
            var.update $found { value = true }
          }
          elseif ($sum_squares < $input.c) {
            // Sum too small, increase a to get larger sum
            var.update $a { value = $a + 1 }
          }
          else {
            // Sum too large, decrease b to get smaller sum
            var.update $b { value = $b - 1 }
          }
        }
      }
    }
  }
  
  response = $found
}
