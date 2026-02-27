function "pascals_triangle_ii" {
  description = "Return the rowIndex-th (0-indexed) row of Pascal's triangle"
  input {
    int row_index filters=min:0 { description = "The row index (0-indexed)" }
  }
  stack {
    var $result { value = [1] }
    
    conditional {
      if ($input.row_index == 0) {
        var.update $result { value = [1] }
      }
      else {
        var $current_row { value = [1] }
        
        for ($input.row_index) {
          each as $i {
            var $prev_row { value = $current_row }
            var $new_row { value = [1] }
            
            var $j { value = 1 }
            while ($j < $prev_row|count) {
              each {
                var $left { value = $prev_row[$j - 1] }
                var $right { value = $prev_row[$j] }
                var $sum { value = $left + $right }
                var.update $new_row { value = $new_row|push:$sum }
                math.add $j { value = 1 }
              }
            }
            
            var.update $new_row { value = $new_row|push:1 }
            var.update $current_row { value = $new_row }
          }
        }
        
        var.update $result { value = $current_row }
      }
    }
  }
  response = $result
}
