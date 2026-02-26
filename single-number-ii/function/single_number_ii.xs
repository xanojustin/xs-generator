function "single_number_ii" {
  description = "Find the single number that appears once where every other number appears exactly 3 times"
  input {
    int[] numbers { description = "Array of integers where every number appears 3 times except one" }
  }
  stack {
    // Approach: Use bit manipulation to count bits at each position
    // For each bit position, count how many numbers have that bit set
    // If the count is not divisible by 3, the single number has that bit set
    
    var $result { value = 0 }
    var $bit_position { value = 0 }
    
    // Iterate through all 32 bits of an integer
    while ($bit_position < 32) {
      each {
        var $bit_count { value = 0 }
        var $i { value = 0 }
        
        // Count how many numbers have the current bit set
        while ($i < ($input.numbers|count)) {
          each {
            // Check if the bit at position $bit_position is set
            // We need to shift 1 left by $bit_position and AND with the number
            // If result is non-zero, the bit is set
            
            // Get current number
            var $current_num { value = $input.numbers[$i] }
            
            // Create mask: 1 << bit_position
            var $mask { value = 1 }
            var $shift_count { value = 0 }
            while ($shift_count < $bit_position) {
              each {
                var.update $mask { value = $mask * 2 }
                var.update $shift_count { value = $shift_count + 1 }
              }
            }
            
            // Check if bit is set: number & mask != 0
            // In XanoScript, we use modulo for bitwise AND approximation
            // Actually, let's use a different approach - convert to binary string
            // and check the bit, then convert back
            
            // Alternative: Use repeated division to check bits
            var $temp_num { value = $current_num }
            var $temp_pos { value = 0 }
            var $bit_is_set { value = false }
            
            // If number is negative, handle two's complement
            conditional {
              if ($temp_num < 0) {
                // For negative numbers in two's complement
                // We need to handle the sign bit specially
                conditional {
                  if ($bit_position == 31) {
                    // Sign bit - check if negative
                    var.update $bit_is_set { value = true }
                    var.update $temp_num { value = 0 }
                  }
                }
                // For other bits, work with absolute value
                conditional {
                  if ($bit_position < 31) {
                    var.update $temp_num { value = 0 - $temp_num }
                  }
                }
              }
            }
            
            // Extract the bit at position $bit_position
            conditional {
              if ($bit_position < 31 && $temp_num > 0) {
                var $div_count { value = 0 }
                var $working_num { value = $temp_num }
                
                while ($div_count < $bit_position) {
                  each {
                    var.update $working_num { value = ($working_num / 2)|to_int }
                    var.update $div_count { value = $div_count + 1 }
                  }
                }
                
                // Check if lowest bit is set
                conditional {
                  if (($working_num % 2) == 1) {
                    var.update $bit_is_set { value = true }
                  }
                }
              }
            }
            
            conditional {
              if ($bit_is_set) {
                var.update $bit_count { value = $bit_count + 1 }
              }
            }
            
            var.update $i { value = $i + 1 }
          }
        }
        
        // If bit_count is not divisible by 3, set this bit in result
        conditional {
          if (($bit_count % 3) != 0) {
            // Add 2^bit_position to result
            var $bit_value { value = 1 }
            var $shift { value = 0 }
            while ($shift < $bit_position) {
              each {
                var.update $bit_value { value = $bit_value * 2 }
                var.update $shift { value = $shift + 1 }
              }
            }
            
            conditional {
              if ($bit_position == 31) {
                // For sign bit, we need to subtract since it's negative
                var.update $result { value = $result - $bit_value }
              }
              else {
                var.update $result { value = $result + $bit_value }
              }
            }
          }
        }
        
        var.update $bit_position { value = $bit_position + 1 }
      }
    }
  }
  response = $result
}
