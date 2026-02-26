// Selection Sort - Classic sorting algorithm
// Sorts an array of integers using the selection sort algorithm
function "selection_sort" {
  description = "Sorts an array of integers using selection sort algorithm"
  
  input {
    int[] numbers { description = "Array of integers to sort" }
  }
  
  stack {
    // Create a copy of the input array
    var $arr { value = $input.numbers }
    var $n { value = $arr|count }
    var $i { value = 0 }
    
    // Selection sort algorithm
    while ($i < $n - 1) {
      each {
        var $min_idx { value = $i }
        var $j { value = $i + 1 }
        
        // Find the minimum element in the unsorted portion
        while ($j < $n) {
          each {
            conditional {
              if ($arr[$j] < $arr[$min_idx]) {
                var.update $min_idx { value = $j }
              }
            }
            var.update $j { value = $j + 1 }
          }
        }
        
        // Swap the found minimum with the first element of unsorted portion
        conditional {
          if ($min_idx != $i) {
            var $temp { value = $arr[$i] }
            var.update $arr[$i] { value = $arr[$min_idx] }
            var.update $arr[$min_idx] { value = $temp }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $arr
}
