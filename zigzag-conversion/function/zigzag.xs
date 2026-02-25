// Converts a string to zigzag pattern on given number of rows
function "zigzag_convert" {
  description = "Converts a string to zigzag pattern and reads row by row"
  
  input {
    text input_string
    int num_rows
  }
  
  stack {
    // Edge case: if only 1 row, return the string as-is
    conditional {
      if ($input.num_rows == 1) {
        return { value = $input.input_string }
      }
    }
    
    // Initialize empty array for each row
    var $rows {
      value = []
    }
    
    // Create empty strings for each row
    var $i { value = 0 }
    while ($i < $input.num_rows) {
      each {
        var $rows {
          value = $rows|push:""
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Track current row and direction
    var $current_row { value = 0 }
    var $going_down { value = false }
    
    // Iterate through each character
    var $char_index { value = 0 }
    var $string_length {
      value = $input.input_string|strlen
    }
    
    while ($char_index < $string_length) {
      each {
        // Get current character using substring
        var $char {
          value = $input.input_string|substr:$char_index:1
        }
        
        // Append character to current row
        var $current_row_string {
          value = $rows|get:$current_row
        }
        var $updated_row_string {
          value = $current_row_string ~ $char
        }
        var $rows {
          value = $rows|set:$current_row:$updated_row_string
        }
        
        // Change direction if we hit top or bottom row
        conditional {
          if ($current_row == 0 || $current_row == ($input.num_rows - 1)) {
            var.update $going_down { value = !$going_down }
          }
        }
        
        // Move to next row
        conditional {
          if ($going_down) {
            var.update $current_row { value = $current_row + 1 }
          }
          else {
            var.update $current_row { value = $current_row - 1 }
          }
        }
        
        // Move to next character
        var.update $char_index { value = $char_index + 1 }
      }
    }
    
    // Join all rows together
    var $result {
      value = $rows|join:""
    }
  }
  
  response = $result
}
