function "power_of_two" {
  description = "Calculate 2 raised to the given exponent"
  input {
    int exponent
  }
  stack {
    conditional {
      if ($input.exponent == 0) {
        var $result { value = 1 }
      }
      else {
        var $result { value = 1 }
        var $i { value = 0 }
        while ($i < $input.exponent) {
          each {
            var.update $result { value = $result * 2 }
            var.update $i { value = $i + 1 }
          }
        }
      }
    }
  }
  response = $result
}
