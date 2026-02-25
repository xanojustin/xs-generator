function "third_maximum_number" {
  description = "Find the third distinct maximum number in an array"
  input {
    int[] nums
  }
  stack {
    // Handle empty array
    precondition (($input.nums|count) > 0) {
      error_type = "inputerror"
      error = "Input array cannot be empty"
    }

    // Find distinct values by tracking unique numbers
    var $distinct {
      value = []
    }

    // Iterate through input to find distinct values
    foreach ($input.nums) {
      each as $num {
        // Check if number is already in distinct list
        var $found {
          value = false
        }

        foreach ($distinct) {
          each as $d {
            conditional {
              if ($d == $num) {
                var.update $found {
                  value = true
                }
              }
            }
          }
        }

        conditional {
          if (!$found) {
            var.update $distinct {
              value = $distinct|merge:[$num]
            }
          }
        }
      }
    }

    // Sort distinct values in descending order using bubble sort approach
    var $n {
      value = $distinct|count
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
            conditional {
              if ($distinct[$j] < $distinct[$j + 1]) {
                // Swap elements
                var $temp {
                  value = $distinct[$j]
                }
                var.update $distinct[$j] {
                  value = $distinct[$j + 1]
                }
                var.update $distinct[$j + 1] {
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

    // Determine result based on number of distinct values
    var $distinct_count {
      value = $distinct|count
    }

    var $result {
      value = 0
    }

    conditional {
      if ($distinct_count >= 3) {
        var.update $result {
          value = $distinct[2]
        }
      }
      else {
        var.update $result {
          value = $distinct[0]
        }
      }
    }
  }
  response = $result
}
