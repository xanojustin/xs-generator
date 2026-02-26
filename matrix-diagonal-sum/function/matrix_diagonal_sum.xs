// Matrix Diagonal Sum - Sum of primary and secondary diagonals
// Given a square matrix, returns the sum of elements on both diagonals
// Note: The center element is counted only once for odd-sized matrices
function "matrix_diagonal_sum" {
  description = "Calculates the sum of primary and secondary diagonal elements in a square matrix"
  
  input {
    object matrix {
      description = "A square matrix (2D array of integers)"
    }
  }
  
  stack {
    var $n { value = $input.matrix|count }
    var $sum { value = 0 }
    var $i { value = 0 }
    
    while ($i < $n) {
      each {
        // Primary diagonal: matrix[i][i]
        var $primary_val {
          value = $input.matrix|get:$i|get:$i
        }
        var.update $sum { value = $sum + $primary_val }
        
        // Secondary diagonal: matrix[i][n-1-i]
        // Skip if it's the same as primary (center element in odd-sized matrix)
        var $secondary_idx { value = $n - 1 - $i }
        
        conditional {
          if ($secondary_idx != $i) {
            var $secondary_val {
              value = $input.matrix|get:$i|get:$secondary_idx
            }
            var.update $sum { value = $sum + $secondary_val }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $sum
}
