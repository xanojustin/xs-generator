// Smallest Difference - Classic coding exercise
// Given two arrays of integers, find the pair (one from each array)
// with the smallest absolute difference and return them as an array [num1, num2]
function "smallest_difference" {
  description = "Finds the pair with the smallest absolute difference between two arrays"
  
  input {
    int[] array1 { description = "First array of integers" }
    int[] array2 { description = "Second array of integers" }
  }
  
  stack {
    // Handle edge cases
    var $len1 { value = $input.array1|count }
    var $len2 { value = $input.array2|count }
    
    // Return empty if either array is empty
    conditional {
      if ($len1 == 0 || $len2 == 0) {
        var $result { value = [] }
      }
      else {
        // Sort both arrays
        var $sorted1 { value = $input.array1|sort }
        var $sorted2 { value = $input.array2|sort }
        
        // Initialize pointers and tracking variables
        var $i { value = 0 }
        var $j { value = 0 }
        // Max int value
        var $smallest_diff { value = 2147483647 }
        var $best_pair { value = [] }
        
        // Two-pointer technique
        while ($i < $len1 && $j < $len2) {
          each {
            var $num1 { value = $sorted1[$i] }
            var $num2 { value = $sorted2[$j] }
            var $current_diff { value = ($num1 - $num2)|abs }
            
            // Update best pair if current difference is smaller
            conditional {
              if ($current_diff < $smallest_diff) {
                var $smallest_diff { value = $current_diff }
                var $best_pair { value = [$num1, $num2] }
              }
            }
            
            // Move pointer based on which number is smaller
            conditional {
              if ($num1 < $num2) {
                var $i { value = $i + 1 }
              }
              elseif ($num1 > $num2) {
                var $j { value = $j + 1 }
              }
              else {
                // Found exact match (difference = 0), can't get better
                // Force exit from loop
                var $i { value = $len1 }
                var $j { value = $len2 }
              }
            }
          }
        }
        
        var $result { value = $best_pair }
      }
    }
  }
  
  response = $result
}
