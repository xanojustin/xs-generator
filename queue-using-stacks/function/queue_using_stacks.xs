// Queue using Stacks - Classic data structure interview problem
// Implements a FIFO queue using two LIFO stacks
function "queue_using_stacks" {
  description = "Queue implementation using two stacks with enqueue, dequeue, peek, and is_empty operations"
  
  input {
    text operation { description = "Operation to perform: enqueue, dequeue, peek, is_empty, or batch" }
    json payload { description = "Operation payload: value for enqueue, or array of operations for batch" }
  }
  
  stack {
    // Initialize two stacks
    // stack_in: for enqueue operations
    // stack_out: for dequeue operations (reversed when needed)
    var $stack_in { value = [] }
    var $stack_out { value = [] }
    
    conditional {
      // Handle single enqueue operation
      if ($input.operation == "enqueue") {
        var $stack_in { value = $stack_in|merge:[$input.payload] }
        var $result { value = { success: true, message: "Enqueued " ~ ($input.payload|to_text) } }
      }
      
      // Handle dequeue operation
      elseif ($input.operation == "dequeue") {
        // If stack_out is empty, transfer from stack_in
        conditional {
          if (($stack_out|count) == 0) {
            // Transfer all elements from stack_in to stack_out (reverses order)
            var $i { value = ($stack_in|count) - 1 }
            while ($i >= 0) {
              each {
                var $stack_out { value = $stack_out|merge:[$stack_in[$i]] }
                var.update $i { value = $i - 1 }
              }
            }
            var $stack_in { value = [] }
          }
        }
        
        conditional {
          if (($stack_out|count) == 0) {
            var $result { value = { success: false, error: "Queue is empty" } }
          }
          else {
            // Pop from stack_out
            var $dequeued { value = $stack_out|last }
            var $new_stack_out { value = [] }
            var $j { value = 0 }
            while ($j < (($stack_out|count) - 1)) {
              each {
                var $new_stack_out { value = $new_stack_out|merge:[$stack_out[$j]] }
                var.update $j { value = $j + 1 }
              }
            }
            var $stack_out { value = $new_stack_out }
            var $result { value = { success: true, value: $dequeued } }
          }
        }
      }
      
      // Handle peek operation (view front element without removing)
      elseif ($input.operation == "peek") {
        // If stack_out is empty, transfer from stack_in
        conditional {
          if (($stack_out|count) == 0) {
            var $i { value = ($stack_in|count) - 1 }
            while ($i >= 0) {
              each {
                var $stack_out { value = $stack_out|merge:[$stack_in[$i]] }
                var.update $i { value = $i - 1 }
              }
            }
            var $stack_in { value = [] }
          }
        }
        
        conditional {
          if (($stack_out|count) == 0) {
            var $result { value = { success: false, error: "Queue is empty" } }
          }
          else {
            var $result { value = { success: true, value: ($stack_out|last) } }
          }
        }
      }
      
      // Handle is_empty operation
      elseif ($input.operation == "is_empty") {
        var $is_empty { value = (($stack_in|count) == 0) && (($stack_out|count) == 0) }
        var $result { value = { success: true, is_empty: $is_empty } }
      }
      
      // Handle batch operations (array of operations)
      elseif ($input.operation == "batch") {
        var $results { value = [] }
        var $current_stack_in { value = [] }
        var $current_stack_out { value = [] }
        
        var $ops { value = $input.payload }
        var $k { value = 0 }
        
        while ($k < ($ops|count)) {
          each {
            var $op { value = $ops[$k] }
            var $op_name { value = $op["operation"] }
            
            conditional {
              // Enqueue in batch
              if ($op_name == "enqueue") {
                var $current_stack_in { value = $current_stack_in|merge:[$op["value"]] }
                var $results { value = $results|merge:[{ operation: "enqueue", value: $op["value"], success: true }] }
              }
              
              // Dequeue in batch
              elseif ($op_name == "dequeue") {
                // Transfer if needed
                conditional {
                  if (($current_stack_out|count) == 0) {
                    var $m { value = ($current_stack_in|count) - 1 }
                    while ($m >= 0) {
                      each {
                        var $current_stack_out { value = $current_stack_out|merge:[$current_stack_in[$m]] }
                        var.update $m { value = $m - 1 }
                      }
                    }
                    var $current_stack_in { value = [] }
                  }
                }
                
                conditional {
                  if (($current_stack_out|count) == 0) {
                    var $results { value = $results|merge:[{ operation: "dequeue", error: "Queue is empty" }] }
                  }
                  else {
                    var $dequeued_val { value = $current_stack_out|last }
                    var $new_out { value = [] }
                    var $n { value = 0 }
                    while ($n < (($current_stack_out|count) - 1)) {
                      each {
                        var $new_out { value = $new_out|merge:[$current_stack_out[$n]] }
                        var.update $n { value = $n + 1 }
                      }
                    }
                    var $current_stack_out { value = $new_out }
                    var $results { value = $results|merge:[{ operation: "dequeue", value: $dequeued_val, success: true }] }
                  }
                }
              }
              
              // Peek in batch
              elseif ($op_name == "peek") {
                conditional {
                  if (($current_stack_out|count) == 0) {
                    var $m { value = ($current_stack_in|count) - 1 }
                    while ($m >= 0) {
                      each {
                        var $current_stack_out { value = $current_stack_out|merge:[$current_stack_in[$m]] }
                        var.update $m { value = $m - 1 }
                      }
                    }
                    var $current_stack_in { value = [] }
                  }
                }
                
                conditional {
                  if (($current_stack_out|count) == 0) {
                    var $results { value = $results|merge:[{ operation: "peek", error: "Queue is empty" }] }
                  }
                  else {
                    var $results { value = $results|merge:[{ operation: "peek", value: ($current_stack_out|last), success: true }] }
                  }
                }
              }
              
              // Is empty in batch
              elseif ($op_name == "is_empty") {
                var $empty_check { value = (($current_stack_in|count) == 0) && (($current_stack_out|count) == 0) }
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
