function "counting-bits" {
  description = "Count the number of 1 bits in binary representation of each number from 0 to n"
  input {
    int n filters=min:0
  }
  stack {
    var $result {
      value = []
    }
    
    for ($input.n + 1) {
      each as $i {
        var $num {
          value = $i
        }
        var $count {
          value = 0
        }
        
        while ($num > 0) {
          each {
            var $isOne {
              value = $num % 2
            }
            conditional {
              if ($isOne == 1) {
                math.add $count {
                  value = 1
                }
              }
            }
            math.div $num {
              value = 2
            }
          }
        }
        
        var $result {
          value = $result|push:$count
        }
      }
    }
  }
  response = $result
}
