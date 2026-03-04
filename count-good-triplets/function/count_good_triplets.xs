function "count_good_triplets" {
  description = "Count the number of good triplets in an array"
  input {
    int[] arr { description = "Array of integers to search for good triplets" }
    int a { description = "Maximum allowed difference between arr[i] and arr[j]" }
    int b { description = "Maximum allowed difference between arr[j] and arr[k]" }
    int c { description = "Maximum allowed difference between arr[i] and arr[k]" }
  }
  stack {
    var $count { value = 0 }
    var $n { value = ($input.arr|count) }
    
    // Outer loop: i from 0 to n-3
    for (($n - 2)) {
      each as $i {
        // Middle loop: j from i+1 to n-2
        for (($n - $i - 1)) {
          each as $j_offset {
            var $j { value = $i + 1 + $j_offset }
            
            // Check first condition: |arr[i] - arr[j]| <= a
            var $diff_ij { value = ($input.arr|slice:$i:1|first) - ($input.arr|slice:$j:1|first) }
            conditional {
              if ($diff_ij < 0) {
                var $diff_ij { value = 0 - $diff_ij }
              }
            }
            
            conditional {
              if ($diff_ij <= $input.a) {
                // Inner loop: k from j+1 to n-1
                for (($n - $j - 1)) {
                  each as $k_offset {
                    var $k { value = $j + 1 + $k_offset }
                    
                    // Check second condition: |arr[j] - arr[k]| <= b
                    var $diff_jk { value = ($input.arr|slice:$j:1|first) - ($input.arr|slice:$k:1|first) }
                    conditional {
                      if ($diff_jk < 0) {
                        var $diff_jk { value = 0 - $diff_jk }
                      }
                    }
                    
                    conditional {
                      if ($diff_jk <= $input.b) {
                        // Check third condition: |arr[i] - arr[k]| <= c
                        var $diff_ik { value = ($input.arr|slice:$i:1|first) - ($input.arr|slice:$k:1|first) }
                        conditional {
                          if ($diff_ik < 0) {
                            var $diff_ik { value = 0 - $diff_ik }
                          }
                        }
                        
                        conditional {
                          if ($diff_ik <= $input.c) {
                            var.update $count { value = $count + 1 }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  response = $count
}
