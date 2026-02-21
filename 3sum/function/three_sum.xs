// 3Sum - Classic coding exercise
// Finds all unique triplets in the array that sum to zero
function "three_sum" {
  description = "Finds all unique triplets in an array that sum to zero"
  
  input {
    int[] nums { description = "Array of integers" }
  }
  
  stack {
    var $result { value = [] }
    var $n { value = $input.nums|count }
    
    // Need at least 3 elements
    conditional {
      if ($n < 3) {
        return { value = $result }
      }
    }
    
    // Sort the array
    var $sorted_nums { value = $input.nums|sort }
    
    // Iterate through the array, fixing one element and using two pointers
    var $i { value = 0 }
    while ($i < ($n - 2)) {
      each {
        // Skip duplicates for the first element
        conditional {
          if ($i > 0) {
            conditional {
              if (($sorted_nums[$i]) == ($sorted_nums[$i - 1])) {
                var $i { value = $i + 1 }
                continue
              }
            }
          }
        }
        
        // Two pointers
        var $left { value = $i + 1 }
        var $right { value = $n - 1 }
        
        while ($left < $right) {
          each {
            var $sum {
              value = ($sorted_nums[$i]) + ($sorted_nums[$left]) + ($sorted_nums[$right])
            }
            
            conditional {
              if ($sum == 0) {
                // Found a triplet
                var $triplet {
                  value = [$sorted_nums[$i], $sorted_nums[$left], $sorted_nums[$right]]
                }
                var $result {
                  value = $result|merge:[$triplet]
                }
                
                // Move left pointer and skip duplicates
                var $left { value = $left + 1 }
                while (($left < $right) && (($sorted_nums[$left]) == ($sorted_nums[$left - 1]))) {
                  each {
                    var $left { value = $left + 1 }
                  }
                }
                
                // Move right pointer and skip duplicates
                var $right { value = $right - 1 }
                while (($left < $right) && (($sorted_nums[$right]) == ($sorted_nums[$right + 1]))) {
                  each {
                    var $right { value = $right - 1 }
                  }
                }
              }
              elseif ($sum < 0) {
                // Sum too small, move left pointer to increase sum
                var $left { value = $left + 1 }
              }
              else {
                // Sum too large, move right pointer to decrease sum
                var $right { value = $right - 1 }
              }
            }
          }
        }
        
        var $i { value = $i + 1 }
      }
    }
  }
  
  response = $result
}
