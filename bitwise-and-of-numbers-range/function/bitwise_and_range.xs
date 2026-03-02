function "bitwise_and_range" {
  description = "Finds the bitwise AND of all numbers in the range [left, right]"
  
  input {
    int left { description = "Left bound of the range (inclusive)" }
    int right { description = "Right bound of the range (inclusive)" }
  }
  
  stack {
    // The key insight: bitwise AND of a range keeps only the common prefix bits
    // As numbers increase, lower bits flip from 0 to 1, making AND result 0 for those bits
    // We right-shift both numbers until they're equal, then left-shift back
    
    var $shift_count { value = 0 }
    var $l { value = $input.left }
    var $r { value = $input.right }
    
    // Find the common prefix by right shifting until l equals r
    while ($l != $r) {
      each {
        var.update $l { value = $l | divide:2 }
        var.update $r { value = $r | divide:2 }
        var.update $shift_count { value = $shift_count + 1 }
      }
    }
    
    // Left shift the common prefix back to get the result
    // Use multiply by 2 for each shift count
    var $result { value = $l }
    for ($shift_count) {
      each as $idx {
        var.update $result { value = $result | multiply:2 }
      }
    }
  }
  
  response = $result
}
