function "calculator" {
  description = "Evaluate a basic arithmetic expression with +, -, *, / operators"
  input {
    text expression filters=trim
  }
  stack {
    // Remove all spaces from expression
    var $s { value = $input.expression|replace:" ":"" }
    var $n { value = ($s|strlen) }
    
    // Stack to hold numbers
    var $stack { value = [] }
    var $num { value = 0 }
    var $op { value = "+" }
    var $i { value = 0 }
    
    // Iterate through each character
    while ($i < $n) {
      each {
        var $ch { value = $s|substr:$i:1 }
        
        // Check if character is a digit
        conditional {
          if ($ch >= "0" && $ch <= "9") {
            // Build the number
            var.update $num { value = ($num * 10) + ($ch|to_int) }
          }
        }
        
        // If operator or last character, process the previous number
        conditional {
          if (($ch < "0" || $ch > "9") || ($i == ($n - 1))) {
            // Process based on previous operator
            switch ($op) {
              case ("+") {
                var $new_stack { 
                  value = $stack|push:$num 
                }
                var.update $stack { value = $new_stack }
              } break
              case ("-") {
                var $neg_num { value = 0 - $num }
                var $new_stack { 
                  value = $stack|push:$neg_num 
                }
                var.update $stack { value = $new_stack }
              } break
              case ("*") {
                var $last_idx { value = ($stack|count) - 1 }
                var $last_val { value = $stack|get:$last_idx }
                var $product { value = $last_val * $num }
                var $new_stack { value = [] }
                // Copy all but last element
                var $j { value = 0 }
                while ($j < $last_idx) {
                  each {
                    var $elem { value = $stack|get:$j }
                    var.update $new_stack { value = $new_stack|push:$elem }
                    var.update $j { value = $j + 1 }
                  }
                }
                var.update $new_stack { value = $new_stack|push:$product }
                var.update $stack { value = $new_stack }
              } break
              case ("/") {
                var $last_idx { value = ($stack|count) - 1 }
                var $last_val { value = $stack|get:$last_idx }
                // Integer division truncating toward zero
                var $quotient { value = 0 }
                conditional {
                  if ($last_val >= 0) {
                    var.update $quotient { value = $last_val / $num }
                  }
                  else {
                    var $abs_quotient { value = (0 - $last_val) / $num }
                    var.update $quotient { value = 0 - $abs_quotient }
                  }
                }
                var $new_stack { value = [] }
                // Copy all but last element
                var $j { value = 0 }
                while ($j < $last_idx) {
                  each {
                    var $elem { value = $stack|get:$j }
                    var.update $new_stack { value = $new_stack|push:$elem }
                    var.update $j { value = $j + 1 }
                  }
                }
                var.update $new_stack { value = $new_stack|push:$quotient }
                var.update $stack { value = $new_stack }
              } break
            }
            
            // Update operator and reset number
            var.update $op { value = $ch }
            var.update $num { value = 0 }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
    
    // Sum all values in stack
    var $result { value = 0 }
    var $k { value = 0 }
    var $stack_len { value = $stack|count }
    while ($k < $stack_len) {
      each {
        var $val { value = $stack|get:$k }
        var.update $result { value = $result + $val }
        var.update $k { value = $k + 1 }
      }
    }
  }
  response = $result
}
