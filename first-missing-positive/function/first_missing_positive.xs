function "first_missing_positive" {
  description = "Find the smallest positive integer missing from an unsorted array"
  input {
    int[] nums
  }
  stack {
    var $n { value = ($input.nums|count) }
    var $arr { value = $input.nums }
    
    var $i { value = 0 }
    while ($i < $n) {
      each {
        var $current { value = $arr|get:$i }
        
        conditional {
          if ($current >= 1 && $current <= $n) {
            var $target_idx { value = $current - 1 }
            var $target_val { value = $arr|get:$target_idx }
            
            conditional {
              if ($current != $target_val) {
                var $temp { value = $target_val }
                var.update $arr { value = $arr|set:$target_idx:$current }
                var.update $arr { value = $arr|set:$i:$temp }
              }
              else {
                math.add $i { value = 1 }
              }
            }
          }
          else {
            math.add $i { value = 1 }
          }
        }
      }
    }
    
    var $result { value = $n + 1 }
    var $j { value = 0 }
    while ($j < $n) {
      each {
        var $val_at_j { value = $arr|get:$j }
        conditional {
          if ($val_at_j != ($j + 1)) {
            var.update $result { value = $j + 1 }
            var.update $j { value = $n }
          }
          else {
            math.add $j { value = 1 }
          }
        }
      }
    }
  }
  response = $result
}
