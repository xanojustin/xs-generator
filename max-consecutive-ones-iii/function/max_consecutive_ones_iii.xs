function "max_consecutive_ones_iii" {
  description = "Find maximum consecutive 1s in binary array with at most k 0 flips"
  input {
    int[] nums { description = "Binary array containing 0s and 1s" }
    int k filters=min:0 { description = "Maximum number of 0s that can be flipped to 1" }
  }
  stack {
    var $left { value = 0 }
    var $zeros_count { value = 0 }
    var $max_length { value = 0 }
    
    foreach ($input.nums) {
      each as $num {
        conditional {
          if ($num == 0) {
            math.add $zeros_count { value = 1 }
          }
        }
        
        while ($zeros_count > $input.k) {
          each {
            conditional {
              if ($input.nums[$left] == 0) {
                math.sub $zeros_count { value = 1 }
              }
            }
            math.add $left { value = 1 }
          }
        }
        
        var $window_size { value = $each.index - $left + 1 }
        conditional {
          if ($window_size > $max_length) {
            var.update $max_length { value = $window_size }
          }
        }
      }
    }
  }
  response = $max_length
}
