function "solve" {
  description = "Find the length of the longest palindromic subsequence in a string"
  input {
    text text
  }
  stack {
    // Get the length of the input string
    var $n {
      value = ($input.text|strlen)
    }
    
    // Edge case: empty string
    conditional {
      if ($n == 0) {
        return { value = 0 }
      }
    }
    
    // Edge case: single character
    conditional {
      if ($n == 1) {
        return { value = 1 }
      }
    }
    
    // Create a 2D DP table using an array of arrays
    // dp[i][j] = length of longest palindromic subsequence in text[i..j]
    var $dp {
      value = []
    }
    
    // Initialize the DP table with zeros
    for ($n) {
      each as $i {
        var $row {
          value = []
        }
        for ($n) {
          each as $j {
            var $row {
              value = $row|append:0
            }
          }
        }
        var $dp {
          value = $dp|append:$row
        }
      }
    }
    
    // Single characters are palindromes of length 1
    for ($n) {
      each as $i {
        var $row {
          value = ($dp|get:$i)|set:$i:1
        }
        var $dp {
          value = $dp|set:$i:$row
        }
      }
    }
    
    // Fill the DP table
    // cl = current length of substring being considered
    for ($n) {
      each as $cl {
        // Skip lengths 0 and 1 (already handled)
        conditional {
          if ($cl <= 1) {
            continue
          }
        }
        
        // Iterate over all starting positions
        var $max_start {
          value = $n - $cl
        }
        
        for (($max_start + 1)) {
          each as $start_offset {
            var $i {
              value = $start_offset
            }
            var $j {
              value = $i + $cl - 1
            }
            
            // Get characters at positions i and j
            var $char_i {
              value = $input.text|substr:$i:1
            }
            var $char_j {
              value = $input.text|substr:$j:1
            }
            
            conditional {
              if ($char_i == $char_j) {
                // Characters match - add 2 to the inner subproblem
                var $inner_length {
                  value = 0
                }
                conditional {
                  if (($j - $i) > 1) {
                    var $inner_row {
                      value = $dp|get:($i + 1)
                    }
                    var $inner_length {
                      value = $inner_row|get:($j - 1)
                    }
                  }
                }
                var $new_val {
                  value = $inner_length + 2
                }
                var $row {
                  value = ($dp|get:$i)|set:$j:$new_val
                }
                var $dp {
                  value = $dp|set:$i:$row
                }
              }
              else {
                // Characters don't match - take max of excluding either end
                var $row_i {
                  value = $dp|get:$i
                }
                var $row_i_next {
                  value = $dp|get:($i + 1)
                }
                var $exclude_j {
                  value = $row_i|get:($j - 1)
                }
                var $exclude_i {
                  value = $row_i_next|get:$j
                }
                var $max_val {
                  value = $exclude_i
                }
                conditional {
                  if ($exclude_j > $exclude_i) {
                    var $max_val {
                      value = $exclude_j
                    }
                  }
                }
                var $row {
                  value = $row_i|set:$j:$max_val
                }
                var $dp {
                  value = $dp|set:$i:$row
                }
              }
            }
          }
        }
      }
    }
    
    // Result is in dp[0][n-1]
    var $first_row {
      value = $dp|get:0
    }
    var $result {
      value = $first_row|get:($n - 1)
    }
  }
  response = $result
}
