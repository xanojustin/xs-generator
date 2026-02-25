function "largest_odd_number" {
  description = "Find the largest odd number that can be formed from a substring of the given numeric string"
  input {
    text num filters=trim
  }
  stack {
    // Find the rightmost odd digit
    var $result { value = "" }
    var $found { value = false }
    var $i { value = ($input.num|strlen) - 1 }
    
    while ($i >= 0 && !$found) {
      each {
        var $digit { value = $input.num|substr:$i:1 }
        var $digit_int { value = $digit|to_int }
        
        conditional {
          if (($digit_int % 2) == 1) {
            // Found an odd digit - take substring from start to this position
            var.update $result { 
              value = $input.num|substr:0:($i + 1) 
            }
            var.update $found { value = true }
          }
        }
        
        var.update $i { value = $i - 1 }
      }
    }
  }
  response = $result
}
