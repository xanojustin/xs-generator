function "pancake_sort" {
  description = "Sort an array using pancake sort algorithm (only prefix reversals allowed)"
  input {
    int[] arr
  }
  stack {
    // Make a copy of the input array to avoid modifying the original
    var $result {
      value = $input.arr
    }
    
    // Get the length of the array
    var $n {
      value = ($input.arr|count)
    }
    
    // Handle empty or single element array
    conditional {
      if ($n <= 1) {
        // Array is already sorted
      }
      else {
        // Start from the full array and reduce the unsorted portion
        var $curr_size {
          value = $n
        }
        
        while ($curr_size > 1) {
          each {
            // Find the index of the maximum element in the unsorted portion
            var $max_idx {
              value = 0
            }
            
            var $i {
              value = 1
            }
            
            while ($i < $curr_size) {
              each {
                conditional {
                  if ($result[$i] > $result[$max_idx]) {
                    var.update $max_idx {
                      value = $i
                    }
                  }
                }
                var.update $i {
                  value = $i + 1
                }
              }
            }
            
            // If max element is not already at the end of unsorted portion
            conditional {
              if ($max_idx != ($curr_size - 1)) {
                // First flip: bring max element to the front (index 0)
                conditional {
                  if ($max_idx != 0) {
                    // Flip from 0 to max_idx
                    var $start {
                      value = 0
                    }
                    var $end {
                      value = $max_idx
                    }
                    
                    while ($start < $end) {
                      each {
                        // Swap elements at start and end
                        var $temp {
                          value = $result[$start]
                        }
                        var.update $result[$start] {
                          value = $result[$end]
                        }
                        var.update $result[$end] {
                          value = $temp
                        }
                        
                        var.update $start {
                          value = $start + 1
                        }
                        var.update $end {
                          value = $end - 1
                        }
                      }
                    }
                  }
                }
                
                // Second flip: bring max element to its correct position (end of unsorted portion)
                var $start2 {
                  value = 0
                }
                var $end2 {
                  value = $curr_size - 1
                }
                
                while ($start2 < $end2) {
                  each {
                    // Swap elements at start2 and end2
                    var $temp2 {
                      value = $result[$start2]
                    }
                    var.update $result[$start2] {
                      value = $result[$end2]
                    }
                    var.update $result[$end2] {
                      value = $temp2
                    }
                    
                    var.update $start2 {
                      value = $start2 + 1
                    }
                    var.update $end2 {
                      value = $end2 - 1
                    }
                  }
                }
              }
            }
            
            // Reduce the unsorted portion by 1
            var.update $curr_size {
              value = $curr_size - 1
            }
          }
        }
      }
    }
  }
  response = $result
}
