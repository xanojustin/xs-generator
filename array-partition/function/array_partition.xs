// Array Partition - Function
// Given an array of 2n integers, group them into n pairs (a1,b1), (a2,b2), ..., (an,bn)
// such that the sum of min(ai, bi) for all i is maximized. Return the maximized sum.
//
// Strategy: Sort the array and pair adjacent elements. The sum of elements at 
// even indices (0, 2, 4, ...) gives the maximum sum.
function "array_partition" {
  description = "Maximize sum of minimums by optimally pairing array elements"
  
  input {
    int[] nums { description = "Array of 2n integers" }
  }
  
  stack {
    // Sort the array in ascending order
    var $sorted_nums { value = $input.nums|sort }
    
    // Initialize sum
    var $max_sum { value = 0 }
    
    // Sum elements at even indices (0, 2, 4, ...)
    // These are the minimums of each adjacent pair after sorting
    var $i { value = 0 }
    var $length { value = $sorted_nums|count }
    
    while ($i < $length) {
      each {
        // Add the element at the current even index
        var $max_sum {
          value = $max_sum + $sorted_nums[$i]
        }
        
        // Move to next even index (skip the odd index which is the pair's max)
        var $i {
          value = $i + 2
        }
      }
    }
  }
  
  response = $max_sum
}
