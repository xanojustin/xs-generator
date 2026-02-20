// Helper function for recursive merge sort
function "merge_sort_helper" {
  description = "Recursively sorts an array using merge sort"
  
  input {
    int[] arr { description = "Array to sort" }
  }
  
  stack {
    var $n { value = $input.arr|count }
    
    // Base case: arrays of 0 or 1 element are already sorted
    conditional {
      if ($n <= 1) {
        var $result { value = $input.arr }
      }
      else {
        // Find the middle point
        var $mid { value = ($n / 2)|floor }
        
        // Split array into left and right halves
        var $left { value = [] }
        var $right { value = [] }
        var $i { value = 0 }
        
        while ($i < $mid) {
          each {
            var $left {
              value = $left ~ [$input.arr[$i]]
            }
            var.update $i { value = $i + 1 }
          }
        }
        
        var $i { value = $mid }
        while ($i < $n) {
          each {
            var $right {
              value = $right ~ [$input.arr[$i]]
            }
            var.update $i { value = $i + 1 }
          }
        }
        
        // Recursively sort both halves
        function.run "merge_sort_helper" {
          input = { arr: $left }
        } as $sorted_left
        
        function.run "merge_sort_helper" {
          input = { arr: $right }
        } as $sorted_right
        
        // Merge the sorted halves
        function.run "merge_arrays" {
          input = { left: $sorted_left, right: $sorted_right }
        } as $result
      }
    }
  }
  
  response = $result
}
