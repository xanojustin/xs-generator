function "stack_operations" {
  description = "Implement a stack data structure with basic LIFO operations"
  input {
    text[]? initial_stack {
      description = "Initial elements to populate the stack (optional)"
    }
    text operation filters=trim|lower {
      description = "Operation to perform: push, pop, peek, isempty, size, or getall"
    }
    text? value {
      description = "Value to push (required only for push operation)"
    }
  }
  stack {
    // Initialize the stack with provided values or empty array
    var $stack { 
      value = $input.initial_stack ?? []
    }
    
    // Handle each operation
    conditional {
      // PUSH: Add element to the top of the stack
      if ($input.operation == "push") {
        precondition ($input.value != null) {
          error_type = "inputerror"
          error = "Value is required for push operation"
        }
        var.update $stack { value = $stack|push:$input.value }
        var $result {
          value = {
            success: true
            operation: "push"
            value: $input.value
            stack: $stack
            size: $stack|count
          }
        }
      }
      
      // POP: Remove and return the top element
      elseif ($input.operation == "pop") {
        precondition (($stack|count) > 0) {
          error_type = "inputerror"
          error = "Cannot pop from an empty stack"
        }
        var $popped { value = $stack|last }
        // Remove last element by slicing up to (but not including) the last index
        var $stack_size { value = $stack|count }
        var $end_index { value = $stack_size - 1 }
        var $new_stack { value = $stack|slice:0:$end_index }
        var $result {
          value = {
            success: true
            operation: "pop"
            popped: $popped
            stack: $new_stack
            size: $new_stack|count
          }
        }
      }
      
      // PEEK: Return top element without removing
      elseif ($input.operation == "peek") {
        precondition (($stack|count) > 0) {
          error_type = "inputerror"
          error = "Cannot peek into an empty stack"
        }
        var $top { value = $stack|last }
        var $result {
          value = {
            success: true
            operation: "peek"
            top: $top
            stack: $stack
            size: $stack|count
          }
        }
      }
      
      // ISEMPTY: Check if stack is empty
      elseif ($input.operation == "isempty") {
        var $is_empty { value = ($stack|count) == 0 }
        var $result {
          value = {
            success: true
            operation: "isempty"
            isempty: $is_empty
            stack: $stack
            size: $stack|count
          }
        }
      }
      
      // SIZE: Return the number of elements
      elseif ($input.operation == "size") {
        var $size { value = $stack|count }
        var $result {
          value = {
            success: true
            operation: "size"
            size: $size
            stack: $stack
          }
        }
      }
      
      // GETALL: Return the entire stack (for testing/debugging)
      elseif ($input.operation == "getall") {
        var $result {
          value = {
            success: true
            operation: "getall"
            stack: $stack
            size: $stack|count
            isempty: ($stack|count) == 0
          }
        }
      }
      
      // Unknown operation
      else {
        var $result {
          value = {
            success: false
            operation: $input.operation
            error: "Unknown operation. Valid operations: push, pop, peek, isempty, size, getall"
          }
        }
      }
    }
  }
  response = $result
}
