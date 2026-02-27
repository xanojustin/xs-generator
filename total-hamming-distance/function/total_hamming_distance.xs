function "total_hamming_distance" {
  description = "Calculate the total Hamming distance between all pairs of numbers in an array"
  input {
    int[] nums { description = "Array of integers" }
  }
  stack {
    var $total_distance { value = 0 }
    var $n { value = $input.nums|count }
    
    // For each bit position (0-30 for 32-bit integers)
    for (31) {
      each as $bit {
        var $count_ones { value = 0 }
        var $bit_mask { value = 2|pow:$bit }
        
        // Count how many numbers have this bit set
        foreach ($input.nums) {
          each as $num {
            conditional {
              if (($num|bitwise_and:$bit_mask) > 0) {
                var $count_ones { value = $count_ones + 1 }
              }
            }
          }
        }
        
        // Numbers with bit unset = total - ones
        var $count_zeros { value = $n - $count_ones }
        
        // Each pair of (one, zero) contributes 1 to Hamming distance at this bit
        var $bit_distance { value = $count_ones * $count_zeros }
        var $total_distance { value = $total_distance + $bit_distance }
      }
    }
  }
  response = $total_distance
}
