// Reverse Bits - Reverses the bits of a given unsigned 32-bit integer
// For example: input 43261596 (00000010100101000000111101001100)
//              output 964176192 (00110010111100000010100101000000)
function "reverse_bits" {
  description = "Reverses the bits of an unsigned 32-bit integer"
  
  input {
    int n { description = "Unsigned 32-bit integer to reverse bits of" }
  }
  
  stack {
    var $result { value = 0 }
    var $i { value = 0 }
    var $current { value = $input.n }
    
    // Iterate through all 32 bits
    while ($i < 32) {
      each {
        // Left shift result by 1 to make room for the next bit
        var $result { value = $result * 2 }
        
        // Get the least significant bit of current and add it to result
        conditional {
          if (`$current % 2 == 1`) {
            var $result { value = $result + 1 }
          }
        }
        
        // Right shift current by 1 (divide by 2)
        var $current { value = $current / 2 }
        
        var $i { value = $i + 1 }
      }
    }
  }
  
  response = $result
}
