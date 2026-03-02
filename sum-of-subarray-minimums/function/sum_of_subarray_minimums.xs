// Sum of Subarray Minimums - Classic monotonic stack problem
// Given an array of integers, find the sum of minimum values in all subarrays
// Uses monotonic stack for O(n) time complexity
function "sum_of_subarray_minimums" {
  description = "Calculates the sum of minimums in all subarrays using monotonic stack"
  
  input {
    int[] arr { description = "Array of integers" }
  }
  
  stack {
    // Modulo for large numbers
    var $mod { value = 1000000007 }
    var $n { value = ($input.arr|count) }
    
    // Arrays to store distances to previous less element and next less element
    var $left { value = [] }
    var $right { value = [] }
    
    // Initialize left and right arrays
    var $i { value = 0 }
    while ($i < $n) {
      each {
        var $left { value = $left|merge:[0] }
        var $right { value = $right|merge:[0] }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Monotonic stack for previous less element (stores indices)
    var $stack { value = [] }
    
    // Calculate left distances (distance to previous less element)
    var $i { value = 0 }
    while ($i < $n) {
      each {
        // Pop while current element is smaller or equal to stack top
        while ((($stack|count) > 0) && ($input.arr[($stack|last)] > $input.arr[$i])) {
          each {
            // Pop from stack
            var $new_stack { value = [] }
            var $j { value = 0 }
            while ($j < (($stack|count) - 1)) {
              each {
                var $new_stack { value = $new_stack|merge:[$stack[$j]] }
                var.update $j { value = $j + 1 }
              }
            }
            var $stack { value = $new_stack }
          }
        }
        
        // Calculate left distance
        conditional {
          if (($stack|count) == 0) {
            // No previous less element, distance is i + 1
            var $left { 
              value = $left|set:($i|to_text):($i + 1)
            }
          }
          else {
            // Distance to previous less element
            var $left {
              value = $left|set:($i|to_text):($i - ($stack|last))
            }
          }
        }
        
        // Push current index to stack
        var $stack { value = $stack|merge:[$i] }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Clear stack for next pass
    var $stack { value = [] }
    
    // Calculate right distances (distance to next less element)
    var $i { value = $n - 1 }
    while ($i >= 0) {
      each {
        // Pop while current element is strictly smaller than stack top
        while ((($stack|count) > 0) && ($input.arr[($stack|last)] >= $input.arr[$i])) {
          each {
            // Pop from stack
            var $new_stack { value = [] }
            var $j { value = 0 }
            while ($j < (($stack|count) - 1)) {
              each {
                var $new_stack { value = $new_stack|merge:[$stack[$j]] }
                var.update $j { value = $j + 1 }
              }
            }
            var $stack { value = $new_stack }
          }
        }
        
        // Calculate right distance
        conditional {
          if (($stack|count) == 0) {
            // No next less element, distance is n - i
            var $right {
              value = $right|set:($i|to_text):($n - $i)
            }
          }
          else {
            // Distance to next less element
            var $right {
              value = $right|set:($i|to_text):(($stack|last) - $i)
            }
          }
        }
        
        // Push current index to stack
        var $stack { value = $stack|merge:[$i] }
        var.update $i { value = $i - 1 }
      }
    }
    
    // Calculate the result
    var $result { value = 0 }
    var $i { value = 0 }
    while ($i < $n) {
      each {
        var $left_dist { value = $left|get:($i|to_text) }
        var $right_dist { value = $right|get:($i|to_text) }
        var $contribution {
          value = $input.arr[$i] * $left_dist * $right_dist
        }
        var $result {
          value = ($result + $contribution) % $mod
        }
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $result
}
