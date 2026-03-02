function "shuffle_string" {
  description = "Restore a shuffled string using an indices array"
  input {
    text s { description = "The shuffled string" }
    int[] indices { description = "Array indicating where each character should go" }
  }
  stack {
    // Validate that string length matches indices length
    var $len { value = $input.s|strlen }
    var $indices_len { value = $input.indices|count }
    
    precondition ($len == $indices_len) {
      error_type = "inputerror"
      error = "String length must match indices array length"
    }
    
    // Initialize result array with empty positions
    var $result_chars { value = [] }
    
    // Build the result by placing each character at its target position
    var $i { value = 0 }
    foreach ($input.indices) {
      each as $target_idx {
        // Get the character at position $i from the input string
        var $char { value = $input.s|substr:$i:1 }
        
        // Add character to result array at target position
        var.update $result_chars { 
          value = $result_chars|set:($target_idx|to_text):$char 
        }
        
        math.add $i { value = 1 }
      }
    }
    
    // Join all characters to form the restored string
    var $result { value = "" }
    for ($len) {
      each as $idx {
        var $char_at_idx { 
          value = $result_chars|get:($idx|to_text):"" 
        }
        var.update $result { 
          value = $result ~ $char_at_idx 
        }
      }
    }
  }
  response = $result
}
