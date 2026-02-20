// Power of Two - Classic coding exercise using bit manipulation
// Returns true if the input number is a power of two (1, 2, 4, 8, 16, etc.)
// A number is a power of two if: n > 0 AND (n & (n - 1)) == 0
// This works because powers of two have exactly one bit set in binary
function "is_power_of_two" {
  description = "Checks if a number is a power of two using bit manipulation"
  
  input {
    int n { description = "The integer to check" }
  }
  
  stack {
    // A number is a power of two if:
    // 1. It's greater than 0 (handles edge case of 0 and negatives)
    // 2. n & (n - 1) equals 0 (bit manipulation trick)
    //
    // Explanation of n & (n - 1):
    // Powers of two in binary: 1=0001, 2=0010, 4=0100, 8=1000
    // Subtracting 1 flips all bits after and including the set bit
    // So n & (n-1) clears the lowest set bit. For powers of two,
    // there's only one set bit, so the result is 0.
    
    var $is_positive {
      value = $input.n > 0
    }
    
    var $n_minus_1 {
      value = $input.n - 1
    }
    
    // Use filter expression for bitwise AND
    var $bitwise_result {
      value = $input.n|bitwise_and:$n_minus_1
    }
    
    var $has_single_bit {
      value = $bitwise_result == 0
    }
    
    var $result {
      value = $is_positive && $has_single_bit
    }
  }
  
  response = $result
}
