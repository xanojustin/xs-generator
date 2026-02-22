function "jumpGame2" {
  description = "Returns the minimum number of jumps to reach the last index"
  
  input {
    int[] nums { description = "Array where each element represents max jump length from that position" }
  }
  
  stack {
    conditional {
      if (($input.nums|count) <= 1) {
        return { value = 0 }
      }
    }
    
    conditional {
      if ($input.nums[0] == 0) {
        return { value = -1 }
      }
    }
    
    var $jumps { value = 0 }
    var $currentEnd { value = 0 }
    var $farthest { value = 0 }
    var $lastIndex { value = ($input.nums|count) - 1 }
    var $i { value = 0 }
    
    while ($i < $lastIndex) {
      each {
        var $reachableFromHere { value = $i + $input.nums[$i] }
        
        conditional {
          if ($reachableFromHere > $farthest) {
            var.update $farthest { value = $reachableFromHere }
          }
        }
        
        conditional {
          if ($i == $currentEnd) {
            var.update $jumps { value = $jumps + 1 }
            var.update $currentEnd { value = $farthest }
            
            conditional {
              if ($currentEnd >= $lastIndex) {
                return { value = $jumps }
              }
            }
            
            conditional {
              if ($currentEnd == $i) {
                return { value = -1 }
              }
            }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $jumps
}
