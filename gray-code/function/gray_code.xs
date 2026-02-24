// Gray Code Generator
// Generates n-bit Gray Code sequence where consecutive values differ by exactly one bit
function "gray_code" {
  description = "Generates n-bit Gray Code sequence"
  
  input {
    int n { description = "Number of bits (must be >= 1)" }
  }
  
  stack {
    // Handle edge case
    conditional {
      if (`$input.n <= 0`) {
        return { value = [] }
      }
    }
    
    // Initialize with 0
    var $result { value = [0] }
    var $i { value = 1 }
    
    // Generate Gray Code iteratively
    while (`$i <= $input.n`) {
      each {
        // Calculate the value to add: 2^(i-1)
        // Use iterative multiplication since bit-shift is not supported
        var $add_val { value = 1 }
        var $k { value = 1 }
        while (`$k < $i`) {
          each {
            var.update $add_val { value = $add_val * 2 }
            var.update $k { value = $k + 1 }
          }
        }
        
        // Get current length before extending
        var $current_len { value = $result|count }
        var $j { value = $current_len - 1 }
        
        // Append mirrored values with offset (traverse backwards)
        while (`$j >= 0`) {
          each {
            var $mirrored_val { value = $result[$j] + $add_val }
            var $result { value = $result|merge:[$mirrored_val] }
            var.update $j { value = $j - 1 }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $result
}
