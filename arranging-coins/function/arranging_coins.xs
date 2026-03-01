function "arranging_coins" {
  description = "Calculate the number of complete staircase rows that can be formed with n coins"
  input {
    int n filters=min:0 { description = "Total number of coins (non-negative integer)" }
  }
  stack {
    var $left { value = 0 }
    var $right { value = $input.n }
    var $result { value = 0 }

    conditional {
      if ($input.n == 0) {
        var $result { value = 0 }
      }
      else {
        while ($left <= $right) {
          each {
            var $mid { value = ($left + $right) / 2 }
            var $coins_needed { value = $mid * ($mid + 1) / 2 }

            conditional {
              if ($coins_needed == $input.n) {
                var $result { value = $mid }
                var $left { value = $right + 1 }
              }
              elseif ($coins_needed < $input.n) {
                var $result { value = $mid }
                var $left { value = $mid + 1 }
              }
              else {
                var $right { value = $mid - 1 }
              }
            }
          }
        }
      }
    }
  }
  response = $result
}
