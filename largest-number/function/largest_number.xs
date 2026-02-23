function "largest_number" {
  description = "Arrange an array of integers to form the largest possible number"
  input {
    int[] numbers
  }
  stack {
    // Handle edge case: empty array
    conditional {
      if (($input.numbers|count) == 0) {
        return { value = "0" }
      }
    }

    // Handle edge case: single element
    conditional {
      if (($input.numbers|count) == 1) {
        return { value = ($input.numbers|first)|to_text }
      }
    }

    // Convert numbers to strings for comparison
    var $str_numbers {
      value = $input.numbers|map:($$|to_text)
    }

    // Bubble sort using custom comparison (a+b > b+a)
    var $n {
      value = $str_numbers|count
    }
    var $sorted {
      value = $str_numbers
    }

    var $i {
      value = 0
    }
    while ($i < $n) {
      each {
        var $j {
          value = 0
        }
        while ($j < ($n - $i - 1)) {
          each {
            // Get adjacent elements
            var $a {
              value = $sorted[$j]
            }
            var $b {
              value = $sorted[$j + 1]
            }

            // Compare a+b vs b+a
            var $ab {
              value = $a ~ $b
            }
            var $ba {
              value = $b ~ $a
            }

            // If a+b < b+a, swap them (we want descending order)
            conditional {
              if ($ab < $ba) {
                // Swap elements
                var $temp {
                  value = $sorted[$j]
                }
                var.update $sorted[$j] {
                  value = $sorted[$j + 1]
                }
                var.update $sorted[$j + 1] {
                  value = $temp
                }
              }
            }

            var.update $j {
              value = $j + 1
            }
          }
        }
        var.update $i {
          value = $i + 1
        }
      }
    }

    // Join the sorted strings
    var $result {
      value = $sorted|join:""
    }

    // Handle case where result is all zeros (e.g., [0, 0, 0])
    conditional {
      if ($result|trim:"0" == "") {
        return { value = "0" }
      }
    }
  }
  response = $result
}
