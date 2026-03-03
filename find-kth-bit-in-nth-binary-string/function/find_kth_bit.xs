function "find_kth_bit" {
  description = "Find the kth bit in the nth binary string Sn"
  
  input {
    int n { description = "The iteration number for Sn" }
    int k { description = "The position of the bit to find (1-indexed)" }
  }
  
  stack {
    // Calculate the length of Sn: 2^n - 1
    var $length { value = (2|pow:$input.n) - 1 }
    
    // Base case: S1 = "0"
    conditional {
      if ($input.n == 1) {
        return { value = "0" }
      }
    }
    
    // Find the middle position
    var $mid { value = ($length + 1) / 2 }
    
    conditional {
      // If k is the middle, it's always "1"
      if ($input.k == $mid) {
        return { value = "1" }
      }
      // If k is in the left half, recurse on n-1 with same k
      elseif ($input.k < $mid) {
        function.run "find_kth_bit" {
          input = { n: $input.n - 1, k: $input.k }
        } as $result
        return { value = $result }
      }
      // If k is in the right half, recurse on n-1 with mirrored position
      // and invert the result
      else {
        var $mirrored_k { value = $length - $input.k + 1 }
        function.run "find_kth_bit" {
          input = { n: $input.n - 1, k: $mirrored_k }
        } as $bit
        conditional {
          if ($bit == "0") {
            return { value = "1" }
          }
          else {
            return { value = "0" }
          }
        }
      }
    }
  }
  
  response = "0"
}
