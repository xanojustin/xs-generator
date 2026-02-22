function "find_median_sorted_arrays" {
  description = "Find the median of two sorted arrays with O(log(min(m,n))) time complexity"
  input {
    int[] nums1
    int[] nums2
  }
  stack {
    var $m { value = ($nums1|count) }
    var $n { value = ($nums2|count) }
    
    conditional {
      if (($m == 0) && ($n == 0)) {
        return { value = null }
      }
    }
    
    var $total { value = $m + $n }
    var $half { value = ($total + 1) / 2 }
    
    var $a { value = $nums1 }
    var $b { value = $nums2 }
    var $a_len { value = $m }
    var $b_len { value = $n }
    
    conditional {
      if ($m > $n) {
        var.update $a { value = $nums2 }
        var.update $b { value = $nums1 }
        var.update $a_len { value = $n }
        var.update $b_len { value = $m }
      }
    }
    
    var $left { value = 0 }
    var $right { value = $a_len }
    
    while ($left <= $right) {
      each {
        var $partition_a { value = ($left + $right) / 2 }
        var $partition_b { value = $half - $partition_a }
        
        var $max_left_a { value = ($partition_a == 0) ? -2147483648 : ($a|get:($partition_a - 1)) }
        var $min_right_a { value = ($partition_a == $a_len) ? 2147483647 : ($a|get:$partition_a) }
        var $max_left_b { value = ($partition_b == 0) ? -2147483648 : ($b|get:($partition_b - 1)) }
        var $min_right_b { value = ($partition_b == $b_len) ? 2147483647 : ($b|get:$partition_b) }
        
        conditional {
          if (($max_left_a <= $min_right_b) && ($max_left_b <= $min_right_a)) {
            conditional {
              if (($total % 2) == 1) {
                var $max_left { value = ($max_left_a > $max_left_b) ? $max_left_a : $max_left_b }
                return { value = $max_left }
              }
              else {
                var $max_left { value = ($max_left_a > $max_left_b) ? $max_left_a : $max_left_b }
                var $min_right { value = ($min_right_a < $min_right_b) ? $min_right_a : $min_right_b }
                return { value = ($max_left + $min_right) / 2.0 }
              }
            }
          }
          elseif ($max_left_a > $min_right_b) {
            var.update $right { value = $partition_a - 1 }
          }
          else {
            var.update $left { value = $partition_a + 1 }
          }
        }
      }
    }
    
    return { value = null }
  }
  response = null
}
