// Jump Game - Classic greedy algorithm exercise
// Determine if you can reach the last index given max jump lengths
function "jumpGame" {
  description = "Determines if you can reach the last index from the first"
  
  input {
    int[] nums { description = "Array where each element represents max jump length from that position" }
  }
  
  stack {
    // Edge case: single element array is always reachable
    conditional {
      if (($input.nums|count) <= 1) {
        return { value = true }
      }
    }
    
    // Greedy approach: track furthest reachable position
    var $furthest { value = 0 }
    var $lastIndex { value = ($input.nums|count) - 1 }
    var $i { value = 0 }
    
    while ($i <= $furthest) {
      each {
        // Update furthest reachable from current position
        var $currentJump { value = $input.nums[$i] }
        var $reachableFromHere { value = $i + $currentJump }
        
        conditional {
          if ($reachableFromHere > $furthest) {
            var.update $furthest { value = $reachableFromHere }
          }
        }
        
        // Check if we can reach the last index
        conditional {
          if ($furthest >= $lastIndex) {
            return { value = true }
          }
        }
        
        var.update $i { value = $i + 1 }
        
        // If current position exceeds furthest reachable, we can't proceed
        conditional {
          if ($i > $furthest) {
            return { value = false }
          }
        }
      }
    }
  }
  
  response = false
}
