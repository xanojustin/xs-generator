// Add Digits (Digital Root) - Classic coding exercise
// Given an integer num, repeatedly add all its digits until the result has only one digit
// Uses the mathematical digital root formula: 1 + (num - 1) % 9 for positive numbers
// Time complexity: O(1), Space complexity: O(1)
function "add_digits" {
  description = "Returns the digital root of a number (repeated sum of digits until single digit)"
  
  input {
    int num { description = "The integer to compute digital root for" }
  }
  
  stack {
    var $result { value = 0 }
    
    conditional {
      // Handle edge case: 0
      if ($input.num == 0) {
        var $result { value = 0 }
      }
      else {
        // Digital root formula: 1 + (num - 1) % 9
        // This works because of modulo arithmetic properties
        // Example: 38 -> 1 + (38 - 1) % 9 = 1 + 37 % 9 = 1 + 1 = 2
        var $result { 
          value = 1 + (($input.num - 1) % 9)
        }
      }
    }
  }
  
  response = $result
}
