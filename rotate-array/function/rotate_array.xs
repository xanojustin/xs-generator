// Rotate Array - Classic array manipulation problem
// Rotates an array to the right by k steps
function "rotate_array" {
  description = "Rotates an array to the right by k steps"
  
  input {
    int[] arr { description = "Array of integers to rotate" }
    int k { description = "Number of steps to rotate right" }
  }
  
  stack {
    // Get array length
    var $n { value = $input.arr|count }
    
    // Handle edge cases
    conditional {
      if ($n <= 1) {
        return { value = $input.arr }
      }
    }
    
    // Normalize k to avoid unnecessary full rotations
    // k modulo n gives effective rotation steps
    var $effective_k { value = $input.k % $n }
    
    conditional {
      if ($effective_k == 0) {
        return { value = $input.arr }
      }
    }
    
    // Calculate split point - elements after this index move to front
    // For right rotation by k: last k elements go to front
    var $split_point { value = $n - $effective_k }
    
    // Create rotated array by combining two slices
    // Elements from split_point to end, followed by elements from 0 to split_point
    var $first_part { value = $input.arr|slice:$split_point:$n }
    var $second_part { value = $input.arr|slice:0:$split_point }
    
    // Combine parts: last k elements + first (n-k) elements
    var $rotated { value = $first_part|merge:$second_part }
  }
  
  response = $rotated
}
