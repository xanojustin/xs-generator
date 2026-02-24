// Self-Dividing Numbers - Returns all self-dividing numbers in a given range
// A self-dividing number is divisible by every digit it contains (no zeros allowed)
function "self_dividing_numbers" {
  description = "Finds all self-dividing numbers in the range [left, right]"
  
  input {
    int left { description = "Lower bound of the range (inclusive)" }
    int right { description = "Upper bound of the range (inclusive)" }
  }
  
  stack {
    var $results { value = [] }
    var $num { value = $input.left }
    
    while ($num <= $input.right) {
      each {
        var $is_self_dividing { value = true }
        var $temp { value = $num }
        
        while ($temp > 0) {
          each {
            var $digit { value = $temp % 10 }
            
            conditional {
              if ($digit == 0) {
                var $is_self_dividing { value = false }
              }
              elseif ($num % $digit != 0) {
                var $is_self_dividing { value = false }
              }
            }
            
            var.update $temp { value = ($temp / 10)|floor }
          }
        }
        
        conditional {
          if ($is_self_dividing == true) {
            var $results { 
              value = $results|merge:[$num]
            }
          }
        }
        
        var.update $num { value = $num + 1 }
      }
    }
  }
  
  response = $results
}
