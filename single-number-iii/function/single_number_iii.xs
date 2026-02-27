function "single_number_iii" {
  description = "Find the two numbers that appear only once in an array where every other number appears twice"
  input {
    int[] nums
  }
  stack {
    // Edge case: need at least 2 elements
    precondition (($input.nums|count) >= 2) {
      error_type = "inputerror"
      error = "Input array must contain at least 2 elements"
    }
    
    // Step 1: XOR all numbers to get XOR of the two single numbers
    // Since x ^ x = 0, all pairs cancel out, leaving only a ^ b
    var $xor_result { value = 0 }
    
    foreach ($input.nums) {
      each as $num {
        math.bitwise.xor $xor_result { value = $num }
      }
    }
    
    // Step 2: Find the rightmost set bit in xor_result
    // This bit is different between the two single numbers
    // Formula: diff = x & (-x), where -x is two's complement = ~x + 1
    // First, get -xor_result using bitwise_not and add 1
    var $neg_xor { 
      value = ($xor_result|bitwise_not)|add:1 
    }
    
    // Then calculate diff = xor_result & (-xor_result)
    var $diff { value = $xor_result }
    math.bitwise.and $diff { value = $neg_xor }
    
    // Step 3: Partition numbers into two groups based on this bit
    // and XOR each group separately
    var $num1 { value = 0 }
    var $num2 { value = 0 }
    
    foreach ($input.nums) {
      each as $n {
        // Check if the bit is set: (n & diff) != 0
        var $bit_check { value = $n }
        math.bitwise.and $bit_check { value = $diff }
        
        conditional {
          if ($bit_check != 0) {
            math.bitwise.xor $num1 { value = $n }
          }
          else {
            math.bitwise.xor $num2 { value = $n }
          }
        }
      }
    }
  }
  response = [$num1, $num2]
}