function "hamming_distance" {
  description = "Calculate the Hamming distance between two integers"
  input {
    int x
    int y
  }
  stack {
    // XOR the two numbers to find bits that differ
    var $xor_result {
      value = $input.x|bitwise_xor:$input.y
    }
    
    // Count the number of 1s in the XOR result
    var $distance {
      value = 0
    }
    
    var $n {
      value = $xor_result
    }
    
    // Brian Kernighan's algorithm to count set bits
    while ($n != 0) {
      each {
        // Clear the least significant bit: n = n & (n - 1)
        var $n_minus_1 {
          value = $n - 1
        }
        var $n {
          value = $n|bitwise_and:$n_minus_1
        }
        // Increment distance counter
        var $distance {
          value = $distance + 1
        }
      }
    }
  }
  response = $distance
}
