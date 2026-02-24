// Running Sum of 1D Array - Builds a prefix sum array
// Each element at index i contains the sum of all elements from index 0 to i
function "running_sum" {
  description = "Returns the running sum (prefix sum) of an integer array"
  
  input {
    int[] nums { description = "Input array of integers" }
  }
  
  stack {
    var $result { value = [] }
    var $current_sum { value = 0 }
    
    // Iterate through each number in the input array
    foreach ($input.nums) {
      each as $num {
        // Add current number to the running sum
        var.update $current_sum { value = $current_sum + $num }
        
        // Append the running sum to the result array
        var $result { 
          value = $result|merge:[$current_sum]
        }
      }
    }
  }
  
  response = $result
}
