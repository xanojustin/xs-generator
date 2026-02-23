// First Bad Version - Binary Search exercise
// Finds the first bad version using minimal API calls
function "firstBadVersion" {
  description = "Finds the first bad version in a sequence using binary search"
  
  input {
    int n { description = "Total number of versions (1 to n)" }
    int firstBad { description = "The actual first bad version (for simulation)" }
  }
  
  stack {
    // Simulated isBadVersion API - in real scenario, this would be external
    // Returns true if version >= firstBad (meaning it's bad)
    
    // Binary search variables
    var $left { value = 1 }
    var $right { value = $input.n }
    var $result { value = 0 }
    
    while ($left < $right) {
      each {
        // Calculate mid to avoid overflow
        var $mid { value = $left + (($right - $left) / 2) }
        
        // Check if mid version is bad (simulated)
        // isBadVersion(mid) = (mid >= firstBad)
        conditional {
          if ($mid >= $input.firstBad) {
            // Mid is bad, first bad is at or before mid
            var $right { value = $mid }
          }
          else {
            // Mid is good, first bad is after mid
            var $left { value = $mid + 1 }
          }
        }
      }
    }
    
    // left == right, found the first bad version
    var $result { value = $left }
  }
  
  response = $result
}
