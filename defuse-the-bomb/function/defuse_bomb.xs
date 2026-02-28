function "defuse_bomb" {
  description = "Decrypt the bomb code by replacing each element based on sum of k next/previous elements"
  input {
    int[] code
    int k
  }
  stack {
    // Get the length of the code array
    var $n {
      value = $input.code|count
    }
    
    // Initialize the result array with zeros
    var $result {
      value = $input.code|map:0
    }
    
    // If k is 0, return all zeros (already initialized)
    conditional {
      if ($input.k == 0) {
        // Result is already all zeros, nothing to do
      }
      elseif ($input.k > 0) {
        // For each position, sum the next k elements
        for ($n) {
          each as $i {
            var $sum {
              value = 0
            }
            // Sum next k elements
            for ($input.k) {
              each as $j {
                // Calculate circular index: (i + j + 1) % n
                var $idx {
                  value = ($i + $j + 1) % $n
                }
                var $sum {
                  value = $sum + ($input.code|get:$idx)
                }
              }
            }
            // Update result at position i
            var $result {
              value = $result|set:$i:$sum
            }
          }
        }
      }
      else {
        // k < 0: sum previous |k| elements
        var $abs_k {
          value = $input.k * -1
        }
        for ($n) {
          each as $i {
            var $sum {
              value = 0
            }
            // Sum previous |k| elements
            for ($abs_k) {
              each as $j {
                // Calculate circular index: (i - j - 1 + n) % n
                // Adding n before mod to handle negative numbers
                var $idx {
                  value = ($i - $j - 1 + $n) % $n
                }
                var $sum {
                  value = $sum + ($input.code|get:$idx)
                }
              }
            }
            // Update result at position i
            var $result {
              value = $result|set:$i:$sum
            }
          }
        }
      }
    }
  }
  response = $result
}
