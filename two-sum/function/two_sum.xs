function "two_sum" {
  description = "Finds two numbers in an array that add up to a target sum"
  
  input {
    json numbers {
      description = "Array of integers to search"
    }
    int target {
      description = "The target sum to find"
    }
  }
  
  stack {
    // Handle edge cases: null input, less than 2 elements
    conditional {
      if ($input.numbers == null || ($input.numbers|count) < 2) {
        return { value = null }
      }
    }
    
    // Use a hash map approach for O(n) time complexity
    // We iterate using range to get indices, accessing values by index
    var $n {
      value = $input.numbers|count
    }
    
    var $result {
      value = null
    }
    
    // Use range to generate indices (0 to n-1)
    foreach ((0..($n - 1))) {
      each as $i {
        conditional {
          if ($result == null) {
            var $num_i {
              value = $input.numbers|get:$i
            }
            
            // Check all subsequent elements
            foreach ((($i + 1)..($n - 1))) {
              each as $j {
                conditional {
                  if ($result == null) {
                    var $num_j {
                      value = $input.numbers|get:$j
                    }
                    
                    conditional {
                      if ($num_i + $num_j == $input.target) {
                        return { value = [$i, $j] }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  
  response = null
}
