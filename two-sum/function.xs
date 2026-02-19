function "two_sum" {
  description = "Find two indices in an array that sum to a target value"
  input {
    int[] nums {
      description = "Array of integers to search"
    }
    int target {
      description = "The target sum value"
    }
  }
  stack {
    var $result { value = [] }
    var $found { value = false }
    var $i { value = 0 }

    while ($i < ($input.nums|count) && !$found) {
      each {
        var $j { value = $i + 1 }

        while ($j < ($input.nums|count) && !$found) {
          each {
            conditional {
              if (($input.nums|get:$i) + ($input.nums|get:$j) == $input.target) {
                var $result {
                  value = [$i, $j]
                }
                var $found { value = true }
              }
            }
            var.update $j { value = $j + 1 }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }
  }
  response = $result
}
