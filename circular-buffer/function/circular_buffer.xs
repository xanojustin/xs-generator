// Circular Buffer (Ring Buffer) - Classic data structure exercise
// A fixed-size buffer that overwrites old data when full (FIFO with circular behavior)
function "circular_buffer" {
  description = "Circular buffer implementation with read, write, clear, isFull, and isEmpty operations"

  input {
    text operation { description = "Operation to perform: 'read', 'write', 'clear', 'isFull', 'isEmpty', 'size', 'capacity'" }
    int capacity { description = "Maximum capacity of the buffer (required for initialization)" }
    json buffer { description = "Current buffer state as array" }
    json read_index { description = "Index for reading (oldest item position)" }
    json write_index { description = "Index for writing (next position to write)" }
    json item { description = "Item to write (required for 'write' operation)" }
  }

  stack {
    // Initialize state with defaults
    var $capacity { value = $input.capacity }
    var $buffer { value = ($input.buffer == null) ? [] : $input.buffer }
    var $read_index { value = ($input.read_index == null) ? 0 : $input.read_index }
    var $write_index { value = ($input.write_index == null) ? 0 : $input.write_index }
    var $result { value = null }
    var $error_msg { value = null }

    // Initialize buffer array if needed
    conditional {
      if (($buffer|count) == 0 && $capacity > 0) {
        var $i { value = 0 }
        while ($i < $capacity) {
          each {
            var $buffer { value = $buffer|merge:[null] }
            var.update $i { value = $i + 1 }
          }
        }
      }
    }

    conditional {
      // Read: Remove and return the oldest item (FIFO)
      if ($input.operation == "read") {
        conditional {
          // Check if buffer is empty (read_index == write_index and slot is null)
          if ($buffer[$read_index] == null) {
            var $error_msg { value = "Cannot read from empty buffer" }
          }
          else {
            // Get the item at read_index
            var $item { value = $buffer[$read_index] }

            // Clear the slot
            var $new_buffer { value = [] }
            var $j { value = 0 }
            while ($j < ($buffer|count)) {
              each {
                conditional {
                  if ($j == $read_index) {
                    var $new_buffer { value = $new_buffer|merge:[null] }
                  }
                  else {
                    var $new_buffer { value = $new_buffer|merge:[$buffer[$j]] }
                  }
                }
                var.update $j { value = $j + 1 }
              }
            }
            var $buffer { value = $new_buffer }

            // Advance read_index circularly
            var $new_read_index { value = ($read_index + 1) % $capacity }
            var $read_index { value = $new_read_index }

            var $result { value = $item }
          }
        }
      }
      // Write: Add item to the buffer
      elseif ($input.operation == "write") {
        conditional {
          if ($input.item == null) {
            var $error_msg { value = "Item is required for write operation" }
          }
          else {
            // Check if we're overwriting (slot not null)
            var $is_overwrite { value = $buffer[$write_index] != null }

            // Write item at write_index
            var $new_buffer { value = [] }
            var $j { value = 0 }
            while ($j < ($buffer|count)) {
              each {
                conditional {
                  if ($j == $write_index) {
                    var $new_buffer { value = $new_buffer|merge:[$input.item] }
                  }
                  else {
                    var $new_buffer { value = $new_buffer|merge:[$buffer[$j]] }
                  }
                }
                var.update $j { value = $j + 1 }
              }
            }
            var $buffer { value = $new_buffer }

            // Advance write_index circularly
            var $new_write_index { value = ($write_index + 1) % $capacity }
            var $write_index { value = $new_write_index }

            // If we overwrote, advance read_index too (oldest item was lost)
            conditional {
              if ($is_overwrite) {
                var $read_index { value = ($read_index + 1) % $capacity }
              }
            }

            var $result { value = true }
          }
        }
      }
      // Clear: Empty the buffer
      elseif ($input.operation == "clear") {
        var $new_buffer { value = [] }
        var $i { value = 0 }
        while ($i < $capacity) {
          each {
            var $new_buffer { value = $new_buffer|merge:[null] }
            var.update $i { value = $i + 1 }
          }
        }
        var $buffer { value = $new_buffer }
        var $read_index { value = 0 }
        var $write_index { value = 0 }
        var $result { value = true }
      }
      // isFull: Check if buffer is full
      elseif ($input.operation == "isFull") {
        var $result { value = $buffer[$write_index] != null }
      }
      // isEmpty: Check if buffer is empty
      elseif ($input.operation == "isEmpty") {
        var $result { value = $buffer[$read_index] == null }
      }
      // size: Return number of items in buffer
      elseif ($input.operation == "size") {
        var $count { value = 0 }
        var $j { value = 0 }
        while ($j < ($buffer|count)) {
          each {
            conditional {
              if ($buffer[$j] != null) {
                var $count { value = $count + 1 }
              }
            }
            var.update $j { value = $j + 1 }
          }
        }
        var $result { value = $count }
      }
      // capacity: Return buffer capacity
      elseif ($input.operation == "capacity") {
        var $result { value = $capacity }
      }
      // Invalid operation
      else {
        var $error_msg { value = "Invalid operation: " ~ $input.operation ~ ". Valid operations are: read, write, clear, isFull, isEmpty, size, capacity" }
      }
    }
  }

  response = {
    success: $error_msg == null,
    result: $result,
    error: $error_msg,
    buffer: $buffer,
    read_index: $read_index,
    write_index: $write_index,
    capacity: $capacity
  }
}
