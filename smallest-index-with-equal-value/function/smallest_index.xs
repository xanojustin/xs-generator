function "smallest_index" {
  description = "Find the smallest index i such that i mod 10 == nums[i]"
  input {
    int[] nums { description = "Array of integers to search" }
  }
  stack {
    var $result { value = -1 }
    var $i { value = 0 }
    
    foreach ($input.nums) {
      each as $val {
        conditional {
          if ($result == -1) {
            var $mod_val { value = $i % 10 }
            conditional {
              if ($mod_val == $val) {
                var.update $result { value = $i }
              }
            }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }
  }
  response = $result
}
