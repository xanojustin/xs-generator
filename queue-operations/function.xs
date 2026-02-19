function "queue_operations" {
  description = "Implement a queue data structure with basic operations"
  input {
    text[]? initial_queue {
      description = "Initial elements to populate the queue (optional)"
    }
    text operation filters=trim|lower {
      description = "Operation to perform: enqueue, dequeue, peek, isempty, size, or getall"
    }
    text? value {
      description = "Value to enqueue (required only for enqueue operation)"
    }
  }
  stack {
    // Initialize the queue with provided values or empty array
    var $queue { 
      value = $input.initial_queue ?? []
    }
    
    // Handle each operation
    conditional {
      // ENQUEUE: Add element to the back of the queue
      if ($input.operation == "enqueue") {
        precondition ($input.value != null) {
          error_type = "inputerror"
          error = "Value is required for enqueue operation"
        }
        var.update $queue { value = $queue|push:$input.value }
        var $result {
          value = {
            success: true
            operation: "enqueue"
            value: $input.value
            queue: $queue
            size: $queue|count
          }
        }
      }
      
      // DEQUEUE: Remove and return the front element
      elseif ($input.operation == "dequeue") {
        precondition (($queue|count) > 0) {
          error_type = "inputerror"
          error = "Cannot dequeue from an empty queue"
        }
        var $dequeued { value = $queue|first }
        // Remove first element by slicing
        var $new_queue { value = $queue|slice:1 }
        var $result {
          value = {
            success: true
            operation: "dequeue"
            dequeued: $dequeued
            queue: $new_queue
            size: $new_queue|count
          }
        }
      }
      
      // PEEK: Return front element without removing
      elseif ($input.operation == "peek") {
        precondition (($queue|count) > 0) {
          error_type = "inputerror"
          error = "Cannot peek into an empty queue"
        }
        var $front { value = $queue|first }
        var $result {
          value = {
            success: true
            operation: "peek"
            front: $front
            queue: $queue
            size: $queue|count
          }
        }
      }
      
      // ISEMPTY: Check if queue is empty
      elseif ($input.operation == "isempty") {
        var $is_empty { value = ($queue|count) == 0 }
        var $result {
          value = {
            success: true
            operation: "isempty"
            isempty: $is_empty
            queue: $queue
            size: $queue|count
          }
        }
      }
      
      // SIZE: Return the number of elements
      elseif ($input.operation == "size") {
        var $size { value = $queue|count }
        var $result {
          value = {
            success: true
            operation: "size"
            size: $size
            queue: $queue
          }
        }
      }
      
      // GETALL: Return the entire queue (for testing/debugging)
      elseif ($input.operation == "getall") {
        var $result {
          value = {
            success: true
            operation: "getall"
            queue: $queue
            size: $queue|count
            isempty: ($queue|count) == 0
          }
        }
      }
      
      // Unknown operation
      else {
        var $result {
          value = {
            success: false
            operation: $input.operation
            error: "Unknown operation. Valid operations: enqueue, dequeue, peek, isempty, size, getall"
          }
        }
      }
    }
  }
  response = $result
}
