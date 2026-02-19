function "merge_sorted_arrays" {
  description = "Merge two sorted arrays into a single sorted array"
  input {
    int[] arr1 {
      description = "First sorted array of integers"
    }
    int[] arr2 {
      description = "Second sorted array of integers"
    }
  }
  stack {
    var $result { value = [] }
    var $i { value = 0 }
    var $j { value = 0 }

    // Merge while both arrays have elements
    while ($i < ($input.arr1|count) && $j < ($input.arr2|count)) {
      each {
        conditional {
          if (($input.arr1|get:$i) <= ($input.arr2|get:$j)) {
            var $result {
              value = $result|merge:[($input.arr1|get:$i)]
            }
            var.update $i { value = $i + 1 }
          }
          else {
            var $result {
              value = $result|merge:[($input.arr2|get:$j)]
            }
            var.update $j { value = $j + 1 }
          }
        }
      }
    }

    // Add remaining elements from arr1 (if any)
    while ($i < ($input.arr1|count)) {
      each {
        var $result {
          value = $result|merge:[($input.arr1|get:$i)]
        }
        var.update $i { value = $i + 1 }
      }
    }

    // Add remaining elements from arr2 (if any)
    while ($j < ($input.arr2|count)) {
      each {
        var $result {
          value = $result|merge:[($input.arr2|get:$j)]
        }
        var.update $j { value = $j + 1 }
      }
    }
  }
  response = $result
}
