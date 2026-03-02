// Arithmetic Slices - Count arithmetic subarrays
function "arithmetic_slices" {
  input {
    int[] nums
  }
  
  stack {
    precondition (($input.nums|count) >= 3) {
      error_type = "inputerror"
      error = "Array must contain at least 3 elements"
    }
    
    var $n { value = $input.nums|count }
    var $count { value = 0 }
    var $current_streak { value = 0 }
    
    for ($n) {
      each as $i {
        conditional {
          if ($i < 2) {
            // Skip first two elements
          }
          elseif ($i >= 2) {
            var $diff1 { 
              value = $input.nums|get:($i|to_int) - $input.nums|get:(($i - 1)|to_int)
            }
            var $diff2 { 
              value = $input.nums|get:(($i - 1)|to_int) - $input.nums|get:(($i - 2)|to_int)
            }
            
            conditional {
              if ($diff1 == $diff2) {
                var.update $current_streak { value = $current_streak + 1 }
                var.update $count { value = $count + $current_streak }
              }
              else {
                var.update $current_streak { value = 0 }
              }
            }
          }
        }
      }
    }
  }
  
  response = $count
}
