function "count_bits" {
  description = "Count the number of 1 bits in the binary representation of an integer"
  input {
    int n
  }
  stack {
    var $count { value = 0 }
    var $num { value = $input.n }
    
    while ($num > 0) {
      each {
        var $is_odd { value = ($num % 2) == 1 }
        conditional {
          if ($is_odd) {
            var.update $count { value = $count + 1 }
          }
        }
        var.update $num { value = ($num / 2)|floor }
      }
    }
  }
  response = $count
}
