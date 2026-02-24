// Four Sum - Classic coding exercise
// Finds all unique quadruplets in the array that sum to target
function "four_sum" {
  description = "Finds all unique quadruplets in an array that sum to target"

  input {
    int[] nums { description = "Array of integers" }
    int target { description = "Target sum value" }
  }

  stack {
    var $result { value = [] }
    var $n { value = $input.nums|count }

    // Need at least 4 elements
    conditional {
      if ($n < 4) {
        return { value = $result }
      }
    }

    // Sort the array
    var $sorted_nums { value = $input.nums|sort }

    // First pointer - iterate through array
    var $i { value = 0 }
    while ($i < ($n - 3)) {
      each {
        // Skip duplicates for first element
        conditional {
          if ($i > 0) {
            conditional {
              if ($sorted_nums[$i] == $sorted_nums[$i - 1]) {
                var.update $i { value = $i + 1 }
                continue
              }
            }
          }
        }

        // Second pointer
        var $j { value = $i + 1 }
        while ($j < ($n - 2)) {
          each {
            // Skip duplicates for second element
            conditional {
              if ($j > ($i + 1)) {
                conditional {
                  if ($sorted_nums[$j] == $sorted_nums[$j - 1]) {
                    var.update $j { value = $j + 1 }
                    continue
                  }
                }
              }
            }

            // Two pointers for remaining sum
            var $left { value = $j + 1 }
            var $right { value = $n - 1 }

            while ($left < $right) {
              each {
                var $current_sum {
                  value = $sorted_nums[$i] + $sorted_nums[$j] + $sorted_nums[$left] + $sorted_nums[$right]
                }

                conditional {
                  if ($current_sum == $input.target) {
                    // Found a quadruplet
                    var $quadruplet {
                      value = [$sorted_nums[$i], $sorted_nums[$j], $sorted_nums[$left], $sorted_nums[$right]]
                    }
                    var $result {
                      value = $result|merge:[$quadruplet]
                    }

                    // Move left pointer and skip duplicates
                    var.update $left { value = $left + 1 }
                    while (($left < $right) && ($sorted_nums[$left] == $sorted_nums[$left - 1])) {
                      each {
                        var.update $left { value = $left + 1 }
                      }
                    }

                    // Move right pointer and skip duplicates
                    var.update $right { value = $right - 1 }
                    while (($left < $right) && ($sorted_nums[$right] == $sorted_nums[$right + 1])) {
                      each {
                        var.update $right { value = $right - 1 }
                      }
                    }
                  }
                  elseif ($current_sum < $input.target) {
                    // Sum too small, increase by moving left
                    var.update $left { value = $left + 1 }
                  }
                  else {
                    // Sum too large, decrease by moving right
                    var.update $right { value = $right - 1 }
                  }
                }
              }
            }

            var.update $j { value = $j + 1 }
          }
        }

        var.update $i { value = $i + 1 }
      }
    }
  }

  response = $result
}
