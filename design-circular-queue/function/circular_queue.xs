function "circular_queue" {
  description = "Implement a circular queue with enqueue, dequeue, front, rear, isEmpty, and isFull operations"
  input {
    int capacity { description = "Maximum capacity of the circular queue" }
    object[] operations {
      description = "Array of operations to perform on the queue"
      schema {
        text type { description = "Operation type: enqueue, dequeue, front, rear, isEmpty, isFull" }
        int? value { description = "Value to enqueue (only for enqueue operation)" }
      }
    }
  }
  stack {
    // Initialize the circular queue state
    var $queue { value = [] }
    var $front { value = 0 }
    var $rear { value = -1 }
    var $size { value = 0 }
    var $max_capacity { value = $input.capacity }
    var $results { value = [] }
    
    foreach ($input.operations) {
      each as $op {
        switch ($op.type) {
          case ("enqueue") {
            conditional {
              if ($size < $max_capacity) {
                // Queue is not full, can enqueue
                var.update $rear {
                  value = ($rear + 1) % $max_capacity
                }
                var $new_queue {
                  value = $queue|push:({ index: $rear, value: $op.value })
                }
                var.update $queue { value = $new_queue }
                var.update $size { value = $size + 1 }
                var $enqueue_result { value = { operation: "enqueue", value: $op.value, success: true } }
                var $results_with_enqueue { value = $results|push:($enqueue_result) }
                var.update $results { value = $results_with_enqueue }
              }
              else {
                // Queue is full
                var $enqueue_fail { value = { operation: "enqueue", value: $op.value, success: false, error: "Queue is full" } }
                var $results_with_fail { value = $results|push:($enqueue_fail) }
                var.update $results { value = $results_with_fail }
              }
            }
          } break
          
          case ("dequeue") {
            conditional {
              if ($size > 0) {
                // Queue is not empty, can dequeue
                var $dequeued_value {
                  value = $queue|filter:(`$$.index == ` ~ $front)|first|get:"value"
                }
                var.update $front {
                  value = ($front + 1) % $max_capacity
                }
                var.update $size { value = $size - 1 }
                var $dequeue_result { value = { operation: "dequeue", value: $dequeued_value, success: true } }
                var $results_with_dequeue { value = $results|push:($dequeue_result) }
                var.update $results { value = $results_with_dequeue }
              }
              else {
                // Queue is empty
                var $dequeue_fail { value = { operation: "dequeue", success: false, error: "Queue is empty" } }
                var $results_with_fail { value = $results|push:($dequeue_fail) }
                var.update $results { value = $results_with_fail }
              }
            }
          } break
          
          case ("front") {
            conditional {
              if ($size > 0) {
                var $front_value {
                  value = $queue|filter:(`$$.index == ` ~ $front)|first|get:"value"
                }
                var $front_result { value = { operation: "front", value: $front_value, success: true } }
                var $results_with_front { value = $results|push:($front_result) }
                var.update $results { value = $results_with_front }
              }
              else {
                var $front_fail { value = { operation: "front", success: false, error: "Queue is empty" } }
                var $results_with_fail { value = $results|push:($front_fail) }
                var.update $results { value = $results_with_fail }
              }
            }
          } break
          
          case ("rear") {
            conditional {
              if ($size > 0) {
                var $rear_value {
                  value = $queue|filter:(`$$.index == ` ~ $rear)|first|get:"value"
                }
                var $rear_result { value = { operation: "rear", value: $rear_value, success: true } }
                var $results_with_rear { value = $results|push:($rear_result) }
                var.update $results { value = $results_with_rear }
              }
              else {
                var $rear_fail { value = { operation: "rear", success: false, error: "Queue is empty" } }
                var $results_with_fail { value = $results|push:($rear_fail) }
                var.update $results { value = $results_with_fail }
              }
            }
          } break
          
          case ("isEmpty") {
            var $isempty_result { value = { operation: "isEmpty", value: ($size == 0), success: true } }
            var $results_with_isempty { value = $results|push:($isempty_result) }
            var.update $results { value = $results_with_isempty }
          } break
          
          case ("isFull") {
            var $isfull_result { value = { operation: "isFull", value: ($size == $max_capacity), success: true } }
            var $results_with_isfull { value = $results|push:($isfull_result) }
            var.update $results { value = $results_with_isfull }
          } break
          
          default {
            var $unknown_result { value = { operation: $op.type, success: false, error: "Unknown operation" } }
            var $results_with_unknown { value = $results|push:($unknown_result) }
            var.update $results { value = $results_with_unknown }
          }
        }
      }
    }
    
    var $final_result {
      value = {
        capacity: $max_capacity,
        current_size: $size,
        front_index: $front,
        rear_index: $rear,
        operation_results: $results
      }
    }
  }
  response = $final_result
}
