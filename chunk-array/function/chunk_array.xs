function "chunk_array" {
  description = "Split an array into chunks of a specified size"
  input {
    int[] array { description = "The input array to chunk" }
    int size filters=min:1 { description = "The size of each chunk (must be at least 1)" }
  }
  stack {
    var $result {
      value = []
    }
    
    var $index {
      value = 0
    }
    
    while ($index < ($input.array|count)) {
      each {
        // Calculate the end index for this chunk
        var $end_index {
          value = $index + $input.size
        }
        
        // Ensure we don't go past the array length
        conditional {
          if ($end_index > ($input.array|count)) {
            var.update $end_index {
              value = $input.array|count
            }
          }
        }
        
        // Extract the chunk using a loop
        var $chunk {
          value = []
        }
        
        var $chunk_index {
          value = $index
        }
        
        while ($chunk_index < $end_index) {
          each {
            // Get the element at chunk_index and add to chunk
            var $element {
              value = $input.array[$chunk_index]
            }
            
            // Add element to chunk
            var $new_chunk {
              value = $chunk
            }
            var.update $new_chunk {
              value = $new_chunk ~ [$element]
            }
            var.update $chunk {
              value = $new_chunk
            }
            
            // Increment chunk_index
            math.add $chunk_index {
              value = 1
            }
          }
        }
        
        // Add chunk to result
        var $new_result {
          value = $result
        }
        var.update $new_result {
          value = $new_result ~ [$chunk]
        }
        var.update $result {
          value = $new_result
        }
        
        // Move to next chunk
        var.update $index {
          value = $end_index
        }
      }
    }
  }
  response = $result
}
