function "max_consecutive_ones" {
  description = "Find the maximum number of consecutive 1s in a binary array"
  input {
    int[] nums
  }
  stack {
    var $max_count {
      value = 0
    }
    var $current_count {
      value = 0
    }

    foreach ($input.nums) {
      each as $num {
        conditional {
          if ($num == 1) {
            var.update $current_count {
              value = $current_count + 1
            }
            conditional {
              if ($current_count > $max_count) {
                var.update $max_count {
                  value = $current_count
                }
              }
            }
          }
          else {
            var.update $current_count {
              value = 0
            }
          }
        }
      }
    }
  }
  response = $max_count
}
