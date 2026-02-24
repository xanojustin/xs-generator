function "is_power_of_four" {
  description = "Check if a given integer is a power of four"
  input {
    int number
  }
  stack {
    // A number is a power of 4 if:
    // 1. It's positive (n > 0)
    // 2. It's a power of 2 (only one bit is set) -> n & (n-1) == 0
    // 3. The set bit is in an even position (0, 2, 4, ...) -> n & 0x55555555 != 0
    // 0x55555555 = 0b01010101010101010101010101010101 (bits at even positions)
    
    conditional {
      if ($input.number <= 0) {
        var $result { value = false }
      }
      else {
        // Check if power of 2: n & (n-1) should be 0
        var $temp { value = $input.number }
        var $n_minus_1 { value = $input.number - 1 }
        math.bitwise.and $temp {
          value = $n_minus_1
        }
        
        conditional {
          if ($temp != 0) {
            // Not a power of 2 (more than one bit set)
            var $result { value = false }
          }
          else {
            // Check if the set bit is in an even position
            // 0x55555555 = 1431655765 in decimal
            var $temp2 { value = $input.number }
            var $mask { value = 1431655765 }
            math.bitwise.and $temp2 {
              value = $mask
            }
            
            conditional {
              if ($temp2 == 0) {
                var $result { value = false }
              }
              else {
                var $result { value = true }
              }
            }
          }
        }
      }
    }
  }
  response = $result
}
