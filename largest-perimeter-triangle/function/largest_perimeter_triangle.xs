// Largest Perimeter Triangle - Greedy Algorithm Exercise
// Given an array of side lengths, find the largest perimeter of a valid triangle
// A valid triangle requires: a + b > c (where a <= b <= c)
// Approach: Sort descending, check consecutive triplets for validity
function "largest_perimeter_triangle" {
  description = "Finds the largest perimeter of a triangle that can be formed from given side lengths"
  
  input {
    int[] sides { description = "Array of integers representing side lengths" }
  }
  
  stack {
    // Initialize result to 0 (no valid triangle found)
    var $max_perimeter { value = 0 }
    
    // Need at least 3 sides to form a triangle
    conditional {
      if (($input.sides|count) < 3) {
        var $max_perimeter { value = 0 }
      }
      else {
        // Sort sides in descending order (largest first)
        var $sorted_sides { value = $input.sides|sort:"desc" }
        var $n { value = $sorted_sides|count }
        var $i { value = 0 }
        var $found { value = false }
        
        // Check consecutive triplets
        // For sorted a >= b >= c, triangle is valid if b + c > a
        while (($i <= ($n - 3)) && !$found) {
          each {
            var $a { value = $sorted_sides[$i] }
            var $b { value = $sorted_sides[$i + 1] }
            var $c { value = $sorted_sides[$i + 2] }
            
            // Check triangle inequality: b + c > a (since a is largest)
            conditional {
              if ($b + $c > $a) {
                // Found valid triangle with largest perimeter
                var $max_perimeter { value = $a + $b + $c }
                var $found { value = true }
              }
            }
            
            var.update $i { value = $i + 1 }
          }
        }
      }
    }
  }
  
  response = $max_perimeter
}
