function "is_strobogrammatic" {
  description = "Check if a number is strobogrammatic (looks the same when rotated 180 degrees)"
  
  input {
    text number { description = "The number to check as a string" }
  }
  
  stack {
    // Strobogrammatic digit pairs: digit -> its 180-degree rotation
    var $pairs {
      value = {
        "0": "0",
        "1": "1",
        "6": "9",
        "8": "8",
        "9": "6"
      }
    }
    
    // Empty string is not strobogrammatic
    precondition ($input.number != "") {
      error_type = "inputerror"
      error = "Number cannot be empty"
    }
    
    var $left { value = 0 }
    var $right { value = ($input.number|strlen) - 1 }
    var $is_strobogrammatic { value = true }
    
    while ($left <= $right && $is_strobogrammatic == true) {
      each {
        var $left_digit { value = $input.number|substr:$left:1 }
        var $right_digit { value = $input.number|substr:$right:1 }
        
        // Check if left digit has a strobogrammatic pair
        var $left_pair {
          value = $pairs|get:$left_digit:"invalid"
        }
        
        conditional {
          if ($left_pair == "invalid") {
            var.update $is_strobogrammatic { value = false }
          }
          elseif ($left_pair != $right_digit) {
            var.update $is_strobogrammatic { value = false }
          }
        }
        
        var.update $left { value = $left + 1 }
        var.update $right { value = $right - 1 }
      }
    }
  }
  
  response = $is_strobogrammatic
}
