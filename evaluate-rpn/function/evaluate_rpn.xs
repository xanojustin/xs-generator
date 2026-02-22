function "evaluate_rpn" {
  description = "Evaluate Reverse Polish Notation (postfix) expression"
  input {
    text[] tokens
  }
  stack {
    var $stack { value = [] }
    
    foreach ($input.tokens) {
      each as $token {
        conditional {
          if ($token == "+" || $token == "-" || $token == "*" || $token == "/") {
            // Pop two operands (second operand is top)
            var $b { value = $stack|last }
            var $a { value = $stack|slice:0:-1|last }
            var $new_stack { value = $stack|slice:0:-2 }
            
            var $result { value = 0 }
            
            switch ($token) {
              case ("+") {
                var.update $result { value = $a + $b }
              } break
              case ("-") {
                var.update $result { value = $a - $b }
              } break
              case ("*") {
                var.update $result { value = $a * $b }
              } break
              case ("/") {
                // Integer division (truncates toward zero)
                var.update $result { value = ($a / $b)|to_int }
              } break
            }
            
            var.update $new_stack { value = $new_stack|append:$result }
            var.update $stack { value = $new_stack }
          }
          else {
            // Token is a number, push to stack
            var $num { value = $token|to_int }
            var.update $stack { value = $stack|append:$num }
          }
        }
      }
    }
    
    var $final_result { value = $stack|first }
  }
  response = $final_result
}
