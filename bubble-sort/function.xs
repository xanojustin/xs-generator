function "bubble-sort" {
  description = "Sort an array of integers using the bubble sort algorithm"
  input {
    int[] numbers {
      description = "Array of integers to sort"
    }
  }
  stack {
    var $arr { value = $input.numbers }
    var $n { value = $arr|count }
    var $swapped { value = true }

    while ($swapped) {
      each {
        var.update $swapped { value = false }
        var $i { value = 0 }

        while ($i < ($n - 1)) {
          each {
            conditional {
              if ($arr[$i] > $arr[$i + 1]) {
                // Swap elements
                var $temp { value = $arr[$i] }
                var.update $arr { value = $arr|set:$i:$arr[$i + 1] }
                var.update $arr { value = $arr|set:($i + 1):$temp }
                var.update $swapped { value = true }
              }
            }
            var.update $i { value = $i + 1 }
          }
        }
      }
    }
  }
  response = $arr
}
