function "binary_search" {
  description = "Search for a target value in a sorted array using binary search algorithm"
  input {
    int[] nums {
      description = "Sorted array of integers in ascending order"
    }
    int target {
      description = "The value to search for"
    }
  }
  stack {
    var $left { value = 0 }
    var $right { value = ($input.nums|count) - 1 }
    var $result { value = -1 }

    while ($left <= $right && $result == -1) {
      each {
        var $mid { value = ($left + $right) / 2 }
        var $mid_value { value = $input.nums|get:$mid }

        conditional {
          if ($mid_value == $input.target) {
            var $result { value = $mid }
          }
          elseif ($mid_value < $input.target) {
            var $left { value = $mid + 1 }
          }
          else {
            var $right { value = $mid - 1 }
          }
        }
      }
    }
  }
  response = $result
}
