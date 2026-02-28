function "shortest_unsorted_subarray" {
  description = "Find the length of the shortest continuous subarray that needs to be sorted in ascending order to make the whole array sorted."
  input {
    int[] nums { description = "Array of integers" }
  }
  stack {
    var $n { value = $input.nums|count }
    var $result { value = 0 }
    
    conditional {
      if (($n) <= 1) {
        var.update $result { value = 0 }
        return { value = 0 }
      }
    }
    
    var $left { value = 0 }
    var $right { value = $n - 1 }
    
    while (($left < $n - 1) && ($input.nums[$left] <= $input.nums[$left + 1])) {
      each {
        math.add $left { value = 1 }
      }
    }
    
    conditional {
      if (($left) == ($n - 1)) {
        var.update $result { value = 0 }
        return { value = 0 }
      }
    }
    
    while (($right > 0) && ($input.nums[$right] >= $input.nums[$right - 1])) {
      each {
        math.add $right { value = -1 }
      }
    }
    
    var $subarray { value = $input.nums|slice:$left:($right + 1) }
    var $sub_min { value = $subarray|min }
    var $sub_max { value = $subarray|max }
    
    while (($left > 0) && ($input.nums[$left - 1] > $sub_min)) {
      each {
        math.add $left { value = -1 }
      }
    }
    
    while (($right < $n - 1) && ($input.nums[$right + 1] < $sub_max)) {
      each {
        math.add $right { value = 1 }
      }
    }
    
    var.update $result { value = $right - $left + 1 }
  }
  response = $result
}
