function "count_steps" {
  description = "Count the number of steps to reduce a number to zero"
  input {
    int num
  }
  stack {
    var $steps { value = 0 }
    var $current { value = $input.num }
    
    while ($current > 0) {
      each {
        conditional {
          if (($current % 2) == 0) {
            // Even number: divide by 2
            var.update $current { value = $current / 2 }
          }
          else {
            // Odd number: subtract 1
            var.update $current { value = $current - 1 }
          }
        }
        var.update $steps { value = $steps + 1 }
      }
    }
  }
  response = $steps
}
