function "quick_sort" {
  description = "Sort an array of integers using the quicksort algorithm"
  input {
    int[] numbers
  }
  stack {
    // Base case: arrays with 0 or 1 element are already sorted
    conditional {
      if (($input.numbers|count) <= 1) {
        return { value = $input.numbers }
      }
    }

    // Choose pivot (last element)
    var $pivot {
      value = $input.numbers|last
    }

    // Create arrays for elements less than, equal to, and greater than pivot
    var $less {
      value = []
    }
    var $equal {
      value = []
    }
    var $greater {
      value = []
    }

    // Partition the array
    foreach ($input.numbers) {
      each as $num {
        conditional {
          if ($num < $pivot) {
            var.update $less {
              value = $less|push:$num
            }
          }
          elseif ($num == $pivot) {
            var.update $equal {
              value = $equal|push:$num
            }
          }
          else {
            var.update $greater {
              value = $greater|push:$num
            }
          }
        }
      }
    }

    // Recursively sort less and greater, then combine
    function.run "quick_sort" {
      input = { numbers: $less }
    } as $sorted_less

    function.run "quick_sort" {
      input = { numbers: $greater }
    } as $sorted_greater

    // Combine: sorted_less + equal + sorted_greater
    var $result {
      value = ($sorted_less|merge:$equal)|merge:$sorted_greater
    }
  }
  response = $result
}
