// Queue Operations - Classic data structure exercise
// Implements a queue with enqueue, dequeue, peek, isEmpty, and size operations
function "queue_operations" {
  description = "Queue data structure implementation with standard operations"
  
  input {
    text operation { description = "Operation to perform: 'enqueue', 'dequeue', 'peek', 'isEmpty', 'size'" }
    json queue { description = "Current queue state as an array (items at index 0 is front)" }
    json item { description = "Item to enqueue (required for 'enqueue' operation)" }
  }
  
  stack {
    // Initialize queue if not provided
    var $queue { value = $input.queue }
    var $result { value = null }
    var $error_msg { value = null }
    
    conditional {
      // Enqueue: Add item to the back of the queue
      if ($input.operation == "enqueue") {
        conditional {
          if ($input.item == null) {
            var $error_msg { value = "Item is required for enqueue operation" }
          }
          else {
            // Add item to the end of the array (back of queue)
            var $queue { value = $queue|merge:[$input.item] }
            var $result { value = $queue }
          }
        }
      }
      // Dequeue: Remove and return the front item
      elseif ($input.operation == "dequeue") {
        conditional {
          if (($queue|count) == 0) {
            var $error_msg { value = "Cannot dequeue from empty queue" }
          }
          else {
            // Get the front item
            var $front_item { value = $queue[0] }
            
            // Create new queue without the front item
            var $new_queue { value = [] }
            var $i { value = 1 }
            while ($i < ($queue|count)) {
              each {
                var $new_queue { value = $new_queue|merge:[$queue[$i]] }
                var.update $i { value = $i + 1 }
              }
            }
            var $queue { value = $new_queue }
            
            var $result { 
              value = {
                item: $front_item,
                queue: $queue
              }
            }
          }
        }
      }
      // Peek: Return front item without removing it
      elseif ($input.operation == "peek") {
        conditional {
          if (($queue|count) == 0) {
            var $error_msg { value = "Cannot peek empty queue" }
          }
          else {
            var $result { value = $queue[0] }
          }
        }
      }
      // isEmpty: Check if queue is empty
      elseif ($input.operation == "isEmpty") {
        var $result { value = ($queue|count) == 0 }
      }
      // size: Return number of items in queue
      elseif ($input.operation == "size") {
        var $result { value = $queue|count }
      }
      // Invalid operation
      else {
        var $error_msg { value = "Invalid operation: " ~ $input.operation ~ ". Valid operations are: enqueue, dequeue, peek, isEmpty, size" }
      }
    }
  }
  
  response = {
    success: $error_msg == null,
    result: $result,
    error: $error_msg,
    queue: $queue
  }
}
