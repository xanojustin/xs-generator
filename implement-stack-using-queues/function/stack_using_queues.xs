// Stack using Queues - Classic data structure interview problem
// Implements a LIFO stack using two FIFO queues
function "stack_using_queues" {
  description = "Stack implementation using two queues with push, pop, peek, and is_empty operations"
  
  input {
    text operation { description = "Operation to perform: push, pop, peek, is_empty, or batch" }
    json payload { description = "Operation payload: value for push, or array of operations for batch" }
  }
  
  stack {
    // Initialize two queues
    // queue_main: main storage for stack elements
    // queue_aux: auxiliary queue for pop/peek operations
    var $queue_main { value = [] }
    var $queue_aux { value = [] }
    
    conditional {
      // Handle push operation - O(1)
      if ($input.operation == "push") {
        var $queue_main { value = $queue_main|merge:[$input.payload] }
        var $result { value = { success: true, message: "Pushed " ~ ($input.payload|to_text) } }
      }
      
      // Handle pop operation - O(n)
      elseif ($input.operation == "pop") {
        conditional {
          if (($queue_main|count) == 0) {
            var $result { value = { success: false, error: "Stack is empty" } }
          }
          else {
            // Move all elements except last to queue_aux
            var $i { value = 0 }
            while ($i < (($queue_main|count) - 1)) {
              each {
                var $queue_aux { value = $queue_aux|merge:[$queue_main[$i]] }
                var.update $i { value = $i + 1 }
              }
            }
            // Get the last element (top of stack)
            var $popped { value = $queue_main[(($queue_main|count) - 1)] }
            // Swap queues - queue_aux becomes new main
            var $queue_main { value = $queue_aux }
            var $queue_aux { value = [] }
            var $result { value = { success: true, value: $popped } }
          }
        }
      }
      
      // Handle peek operation - view top element without removing - O(n)
      elseif ($input.operation == "peek") {
        conditional {
          if (($queue_main|count) == 0) {
            var $result { value = { success: false, error: "Stack is empty" } }
          }
          else {
            // The top of stack is the last element in queue_main
            var $top { value = $queue_main[(($queue_main|count) - 1)] }
            var $result { value = { success: true, value: $top } }
          }
        }
      }
      
      // Handle is_empty operation - O(1)
      elseif ($input.operation == "is_empty") {
        var $is_empty { value = ($queue_main|count) == 0 }
        var $result { value = { success: true, is_empty: $is_empty } }
      }
      
      // Handle batch operations (array of operations)
      elseif ($input.operation == "batch") {
        var $results { value = [] }
        var $current_main { value = [] }
        var $current_aux { value = [] }
        
        var $ops { value = $input.payload }
        var $k { value = 0 }
        
        while ($k < ($ops|count)) {
          each {
            var $op { value = $ops[$k] }
            var $op_name { value = $op["operation"] }
            
            conditional {
              // Push in batch - O(1)
              if ($op_name == "push") {
                var $current_main { value = $current_main|merge:[$op["value"]] }
                var $results { value = $results|merge:[{ operation: "push", value: $op["value"], success: true }] }
              }
              
              // Pop in batch - O(n)
              elseif ($op_name == "pop") {
                conditional {
                  if (($current_main|count) == 0) {
                    var $results { value = $results|merge:[{ operation: "pop", error: "Stack is empty" }] }
                  }
                  else {
                    // Move all elements except last to aux
                    var $m { value = 0 }
                    while ($m < (($current_main|count) - 1)) {
                      each {
                        var $current_aux { value = $current_aux|merge:[$current_main[$m]] }
                        var.update $m { value = $m + 1 }
                      }
                    }
                    var $popped_val { value = $current_main[(($current_main|count) - 1)] }
                    var $current_main { value = $current_aux }
                    var $current_aux { value = [] }
                    var $results { value = $results|merge:[{ operation: "pop", value: $popped_val, success: true }] }
                  }
                }
              }
              
              // Peek in batch - O(1) since we just read last element
              elseif ($op_name == "peek") {
                conditional {
                  if (($current_main|count) == 0) {
                    var $results { value = $results|merge:[{ operation: "peek", error: "Stack is empty" }] }
                  }
                  else {
                    var $peek_val { value = $current_main[(($current_main|count) - 1)] }
                    var $results { value = $results|merge:[{ operation: "peek", value: $peek_val, success: true }] }
                  }
                }
              }
              
              // Is empty in batch - O(1)
              elseif ($op_name == "is_empty") {
                var $empty_check { value = ($current_main|count) == 0 }
                var $results { value = $results|merge:[{ operation: "is_empty", is_empty: $empty_check, success: true }] }
              }
            }
            
            var.update $k { value = $k + 1 }
          }
        }
        
        var $result { value = { success: true, operations: $results } }
      }
      
      // Unknown operation
      else {
        var $result { value = { success: false, error: "Unknown operation: " ~ $input.operation } }
      }
    }
  }
  
  response = $result
}
