// Stack Operations - Data structure exercise
// Implements a stack (LIFO) with push, pop, and peek operations
function "stack_operations" {
  description = "Performs stack operations (push, pop, peek) on a stack"
  
  input {
    text[] stack { description = "Initial stack array (bottom to top order)" }
    text operation { description = "Operation to perform: push, pop, or peek" }
    text value { description = "Value to push (only used for push operation)" }
  }
  
  stack {
    // Get the current stack size
    var $stack_size { value = $input.stack|count }
    var $result { value = null }
    var $error_msg { value = null }
    
    conditional {
      // PUSH operation - add element to top of stack
      if ($input.operation == "push") {
        conditional {
          if ($input.value == null) {
            var $error_msg { value = "Value is required for push operation" }
          }
          else {
            var $new_stack {
              value = $input.stack|merge:[$input.value]
            }
            var $result {
              value = {
                stack: $new_stack,
                top: $input.value,
                size: $stack_size + 1,
                operation: "push"
              }
            }
          }
        }
      }
      
      // POP operation - remove and return top element
      elseif ($input.operation == "pop") {
        conditional {
          if ($stack_size == 0) {
            var $error_msg { value = "Cannot pop from empty stack" }
          }
          else {
            var $top_index { value = $stack_size - 1 }
            var $top_value { value = $input.stack[$top_index] }
            var $new_stack {
              value = $input.stack|slice:0:$top_index
            }
            var $result {
              value = {
                stack: $new_stack,
                popped: $top_value,
                size: $stack_size - 1,
                operation: "pop"
              }
            }
          }
        }
      }
      
      // PEEK operation - view top element without removing
      elseif ($input.operation == "peek") {
        conditional {
          if ($stack_size == 0) {
            var $error_msg { value = "Cannot peek empty stack" }
          }
          else {
            var $top_index { value = $stack_size - 1 }
            var $top_value { value = $input.stack[$top_index] }
            var $result {
              value = {
                stack: $input.stack,
                top: $top_value,
                size: $stack_size,
                operation: "peek"
              }
            }
          }
        }
      }
      
      // Invalid operation
      else {
        var $error_msg { value = "Invalid operation: " ~ $input.operation ~ ". Use 'push', 'pop', or 'peek'." }
      }
    }
  }
  
  response = {
    success: $error_msg == null,
    result: $result,
    error: $error_msg
  }
}
