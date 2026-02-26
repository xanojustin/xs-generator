function "valid_triangle_number" {
  description = "Count the number of valid triangles that can be formed from an array of integers"
  input {
    int[] sides { description = "Array of integers representing potential triangle side lengths" }
  }
  stack {
    // Sort the array to use two-pointer technique
    var $sorted_sides {
      value = $input.sides|sort
    }
    
    // Get the count of sides
    var $n {
      value = $sorted_sides|count
    }
    
    // Initialize triangle count
    var $triangle_count {
      value = 0
    }
    
    // Iterate from the end (largest sides first) as the potential largest side
    var $c_index {
      value = $n - 1
    }
    
    while ($c_index >= 2) {
      each {
        // Two pointers: one at start, one just before c
        var $left {
          value = 0
        }
        var $right {
          value = $c_index - 1
        }
        
        // Find all pairs where sides[left] + sides[right] > sides[c_index]
        while ($left < $right) {
          each {
            var $side_a {
              value = $sorted_sides|get:$left:0
            }
            var $side_b {
              value = $sorted_sides|get:$right:0
            }
            var $side_c {
              value = $sorted_sides|get:$c_index:0
            }
            
            // Check if these three sides can form a valid triangle
            // Since sorted_sides is sorted, side_a <= side_b <= side_c
            // We only need to check: side_a + side_b > side_c
            conditional {
              if ($side_a + $side_b > $side_c) {
                // All pairs between left and right with this c_index are valid
                // So we add (right - left) to count and move right pointer
                var $pairs {
                  value = $right - $left
                }
                var.update $triangle_count {
                  value = $triangle_count + $pairs
                }
                var.update $right {
                  value = $right - 1
                }
              }
              else {
                // Sum is too small, need larger sum - move left pointer
                var.update $left {
                  value = $left + 1
                }
              }
            }
          }
        }
        
        // Move to next largest side
        var.update $c_index {
          value = $c_index - 1
        }
      }
    }
  }
  response = $triangle_count
}
