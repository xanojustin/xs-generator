// Maximum 69 Number
// Given a positive integer consisting only of digits 6 and 9,
// return the maximum number by changing at most one digit (6 becomes 9)
function "maximum_69_number" {
  description = "Returns maximum number by changing at most one 6 to 9"
  
  input {
    int num { description = "Positive integer containing only digits 6 and 9" }
  }
  
  stack {
    // Convert number to text to manipulate digits
    var $num_text { value = $input.num|to_text }
    var $length { value = $num_text|strlen }
    
    // Build result by finding first '6' and changing to '9'
    var $result_text { value = "" }
    var $found_six { value = false }
    var $i { value = 0 }
    
    while ($i < $length) {
      each {
        // Get current character
        var $char { value = $num_text|substr:$i:1 }
        
        conditional {
          // If we haven't found a 6 yet and this char is 6, change to 9
          if (!$found_six && $char == "6") {
            var $result_text { value = $result_text ~ "9" }
            var $found_six { value = true }
          }
          else {
            // Keep original character
            var $result_text { value = $result_text ~ $char }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
    
    // Convert result back to integer
    var $result { value = $result_text|to_int }
  }
  
  response = $result
}
