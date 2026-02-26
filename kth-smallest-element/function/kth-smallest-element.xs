// Find Kth Smallest Element
// Given an unsorted array of integers and a value k,
// returns the kth smallest element in the array (1-indexed)
function "kth-smallest-element" {
  description = "Finds the kth smallest element in an unsorted array"
  
  input {
    int[] numbers { description = "Array of integers" }
    int k { description = "Position of the element to find (1-indexed)" }
  }
  
  stack {
    // Validate k is within valid range
    precondition (`$input.k > 0`) {
      error_type = "inputerror"
      error = "k must be positive"
    }
    
    precondition (`$input.k <= ($input.numbers|count)`) {
      error_type = "inputerror"
      error = "k cannot be larger than array length"
    }
    
    // Handle empty array edge case
    precondition (($input.numbers|count) > 0) {
      error_type = "inputerror"
      error = "Array cannot be empty"
    }
    
    // Sort the array to find kth smallest element
    // In XanoScript, we'll use a simple bubble sort approach
    var $sorted { value = $input.numbers }
    var $n { value = $sorted|count }
    var $i { value = 0 }
    
    while ($i < $n) {
      each {
        var $j { value = 0 }
        var $swapped { value = false }
        
        while ($j < ($n - $i - 1)) {
          each {
            conditional {
              if (`$sorted|get:$j > $sorted|get:($j + 1)`) {
                // Swap elements
                var $temp { value = $sorted|get:$j }
                var $sorted {
                  value = $sorted|set:$j:($sorted|get:($j + 1))
                }
                var $sorted {
                  value = $sorted|set:($j + 1):$temp
                }
                var.update $swapped { value = true }
              }
            }
            var.update $j { value = $j + 1 }
          }
        }
        
        // Early exit if no swaps (array already sorted)
        conditional {
          if (`$swapped == false`) {
            return { value = $sorted|get:($input.k - 1) }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $sorted|get:($input.k - 1)
}
