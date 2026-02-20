// Bubble Sort - Classic sorting algorithm
// Sorts an array of integers using the bubble sort algorithm
function "bubble_sort" {
  description = "Sorts an array of integers using bubble sort algorithm"
  
  input {
    int[] numbers { description = "Array of integers to sort" }
  }
  
  stack {
    // Create a copy of the input array to avoid mutating the original
    var $arr { value = $input.numbers }
    var $n { value = $arr|count }
    var $swapped { value = false }
    
    // Outer loop - passes through the array
    while ($n > 1) {
      each {
        var $i { value = 0 }
        var $swapped { value = false }
        
        // Inner loop - compare adjacent elements
        while ($i < $n - 1) {
          each {
            // Get adjacent elements
            var $current { value = $arr[$i] }
            var $next { value = $arr[$i + 1] }
            
            // Swap if current > next (bubble up the larger element)
            conditional {
              if ($current > $next) {
                // Perform swap
                var $temp { value = $current }
                var.update $arr[$i] { value = $next }
                var.update $arr[$i + 1] { value = $temp }
                var $swapped { value = true }
              }
            }
            
            var.update $i { value = $i + 1 }
          }
        }
        
        // Reduce range since largest element is now at the end
        var.update $n { value = $n - 1 }
        
        // If no swaps occurred, array is sorted
        conditional {
          if ($swapped == false) {
            // Force exit by setting n to 1
            var.update $n { value = 1 }
          }
        }
      }
    }
  }
  
  response = $arr
}
