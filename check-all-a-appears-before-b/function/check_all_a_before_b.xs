// Check if All A's Appears Before All B's
// Given a string of only 'a' and 'b', return true if all 'a's appear before all 'b's
function "check_all_a_before_b" {
  description = "Checks if all 'a's appear before all 'b's in the string"
  
  input {
    text s { description = "String containing only letters 'a' and 'b'" }
  }
  
  stack {
    var $found_b { value = false }
    var $valid { value = true }
    var $chars { value = $input.s|split:"" }
    var $i { value = 0 }
    
    while (($i < ($chars|count)) && $valid) {
      each {
        var $char { value = $chars[$i] }
        
        conditional {
          if ($char == "b") {
            var $found_b { value = true }
          }
          elseif (($char == "a") && $found_b) {
            // Found 'a' after seeing a 'b' - invalid
            var $valid { value = false }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $valid
}
