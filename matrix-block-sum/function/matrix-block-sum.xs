// Matrix Block Sum - 2D Prefix Sum Problem
// For each cell (i,j), return the sum of all elements within a k-radius block
// where the block is defined by rows [i-k, i+k] and columns [j-k, j+k]
function "matrix-block-sum" {
  description = "Compute block sums for each cell using 2D prefix sum"

  input {
    json matrix { description = "2D matrix of integers" }
    int k { description = "Radius of the block to sum" }
  }

  stack {
    // Get matrix dimensions
    var $m { value = $input.matrix|count }
    var $n { value = ($input.matrix|first)|count }
    var $k { value = $input.k }

    // Build 2D prefix sum array where prefix[i][j] = sum of all elements from (0,0) to (i-1,j-1)
    // prefix has size (m+1) x (n+1) with row 0 and col 0 as padding zeros
    var $prefix { value = [] }

    // Initialize prefix with (m+1) rows of (n+1) zeros
    for (($m + 1)) {
      each as $i {
        var $row { value = [] }
        for (($n + 1)) {
          each as $j {
            var $row { value = $row|merge:[0] }
          }
        }
        var $prefix { value = $prefix|merge:[$row] }
      }
    }

    // Fill prefix sum array using: prefix[i][j] = matrix[i-1][j-1] + prefix[i-1][j] + prefix[i][j-1] - prefix[i-1][j-1]
    for ($m) {
      each as $i {
        var $i_1 { value = $i + 1 }
        for ($n) {
          each as $j {
            var $j_1 { value = $j + 1 }
            var $matrix_val { value = ($input.matrix|get:$i)|get:$j }
            var $prefix_i1_j { value = ($prefix|get:$i)|get:$j_1 }
            var $prefix_i_j1 { value = ($prefix|get:$i_1)|get:$j }
            var $prefix_i_j { value = ($prefix|get:$i)|get:$j }
            var $prefix_val { value = $matrix_val + $prefix_i1_j + $prefix_i_j1 - $prefix_i_j }

            // Update the prefix array at position [i+1][j+1]
            var $prefix_row { value = $prefix|get:$i_1 }
            var $new_row { value = $prefix_row|slice:0:$j_1 }
            var $new_row { value = $new_row|merge:[$prefix_val] }
            var $remaining { value = $prefix_row|slice:($j_1 + 1):($n + 1) }
            var $new_row { value = $new_row|merge:$remaining }
            var $prefix_before { value = $prefix|slice:0:$i_1 }
            var $prefix_after { value = $prefix|slice:($i_1 + 1):($m + 1) }
            var $prefix { value = $prefix_before|merge:[$new_row]|merge:$prefix_after }
          }
        }
      }
    }

    // Build result matrix
    var $result { value = [] }

    for ($m) {
      each as $i {
        var $result_row { value = [] }
        for ($n) {
          each as $j {
            // Calculate block boundaries with clamping
            var $r1 { value = $i - $k }
            conditional {
              if ($r1 < 0) {
                var $r1 { value = 0 }
              }
            }
            var $c1 { value = $j - $k }
            conditional {
              if ($c1 < 0) {
                var $c1 { value = 0 }
              }
            }
            var $r2 { value = $i + $k }
            conditional {
              if ($r2 >= $m) {
                var $r2 { value = $m - 1 }
              }
            }
            var $c2 { value = $j + $k }
            conditional {
              if ($c2 >= $n) {
                var $c2 { value = $n - 1 }
              }
            }

            // Convert to 1-indexed for prefix sum
            var $r1_1 { value = $r1 + 1 }
            var $c1_1 { value = $c1 + 1 }
            var $r2_1 { value = $r2 + 1 }
            var $c2_1 { value = $c2 + 1 }

            // Query prefix sum: sum = prefix[r2+1][c2+1] - prefix[r1][c2+1] - prefix[r2+1][c1] + prefix[r1][c1]
            var $bottom_right { value = ($prefix|get:$r2_1)|get:$c2_1 }
            var $top_right { value = ($prefix|get:$r1)|get:$c2_1 }
            var $bottom_left { value = ($prefix|get:$r2_1)|get:$c1 }
            var $top_left { value = ($prefix|get:$r1)|get:$c1 }
            var $block_sum { value = $bottom_right - $top_right - $bottom_left + $top_left }

            var $result_row { value = $result_row|merge:[$block_sum] }
          }
        }
        var $result { value = $result|merge:[$result_row] }
      }
    }
  }

  response = $result
}
