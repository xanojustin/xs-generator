function "kth_factor" {
  description = "Find the kth factor of n"
  input {
    int n filters=min:1 { description = "The number to find factors of" }
    int k filters=min:1 { description = "The position of the factor to find" }
  }
  stack {
    var $factors { value = [] }
    var $i { value = 1 }
    
    while ($i <= $input.n) {
      each {
        conditional {
          if ($input.n % $i == 0) {
            var $factors {
              value = $factors|push:$i
            }
          }
        }
        var $i { value = $i + 1 }
      }
    }
    
    var $factor_count { value = $factors|count }
    
    conditional {
      if ($factor_count < $input.k) {
        var $result { value = -1 }
      }
      else {
        var $result { value = $factors[$input.k - 1] }
      }
    }
  }
  response = $result
}
