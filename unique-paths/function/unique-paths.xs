function "unique-paths" {
  description = "Count unique paths from top-left to bottom-right in an m×n grid (moving only right or down)"

  input {
    int rows {
      description = "Number of rows in the grid"
    }
    int cols {
      description = "Number of columns in the grid"
    }
  }

  stack {
    // Handle edge cases - if grid is 0x0 or negative, return 0
    conditional {
      if (`$rows <= 0 || $cols <= 0`) {
        var $result {
          value = 0
        }
      }
      else {
        // Use dynamic programming with a 1D array to save space
        // dp[j] represents the number of ways to reach the current row's j-th column
        
        // Initialize dp array with 1s (first row has all 1s)
        var $dp {
          value = []
        }
        
        // Fill dp with 1s for the first row using range operator
        foreach ((0..($cols - 1))) {
          each as $_ {
            var $dp {
              value = $dp ~ [1]
            }
          }
        }
        
        // For each subsequent row, update dp
        // dp[j] = dp[j] (from above) + dp[j-1] (from left)
        foreach ((1..($rows - 1))) {
          each as $i {
            // Start from column 1 since column 0 is always 1
            foreach ((1..($cols - 1))) {
              each as $j {
                // dp[j] = dp[j] + dp[j-1]
                var $from_above {
                  value = $dp|get:$j
                }
                var $from_left {
                  value = $dp|get:($j - 1)
                }
                var $new_val {
                  value = `$from_above + $from_left`
                }
                var $dp {
                  value = $dp|set:$j:$new_val
                }
              }
            }
          }
        }
        
        var $result {
          value = $dp|get:($cols - 1)
        }
      }
    }
  }

  response = $result
}
