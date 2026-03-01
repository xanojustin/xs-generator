// Lucky Numbers in a Matrix
// A lucky number is an element that is the minimum in its row
// and the maximum in its column
function "lucky-numbers-matrix" {
  description = "Finds all lucky numbers in a matrix"
  
  input {
    json matrix { description = "2D array of integers" }
  }
  
  stack {
    // Get dimensions
    var $rows { value = ($input.matrix|count) }
    var $cols { value = ($input.matrix|first)|count }
    
    // Store min of each row
    var $row_mins { value = [] }
    
    // Find min of each row
    foreach ($input.matrix) {
      each as $row {
        var $row_min { value = $row|first }
        foreach ($row) {
          each as $val {
            conditional {
              if ($val < $row_min) {
                var.update $row_min { value = $val }
              }
            }
          }
        }
        var $row_mins { value = $row_mins|merge:[$row_min] }
      }
    }
    
    // Store max of each column
    var $col_maxs { value = [] }
    
    // Find max of each column
    var $col_idx { value = 0 }
    while ($col_idx < $cols) {
      each {
        var $col_max { value = $input.matrix|first|get:$col_idx }
        var $row_idx { value = 0 }
        while ($row_idx < $rows) {
          each {
            var $val { value = $input.matrix|get:$row_idx|get:$col_idx }
            conditional {
              if ($val > $col_max) {
                var.update $col_max { value = $val }
              }
            }
            var.update $row_idx { value = $row_idx + 1 }
          }
        }
        var $col_maxs { value = $col_maxs|merge:[$col_max] }
        var.update $col_idx { value = $col_idx + 1 }
      }
    }
    
    // Find lucky numbers (min in row AND max in column)
    var $lucky_numbers { value = [] }
    
    var $r { value = 0 }
    while ($r < $rows) {
      each {
        var $c { value = 0 }
        while ($c < $cols) {
          each {
            var $val { value = $input.matrix|get:$r|get:$c }
            var $row_min { value = $row_mins|get:$r }
            var $col_max { value = $col_maxs|get:$c }
            
            conditional {
              if ($val == $row_min && $val == $col_max) {
                var $lucky_numbers { value = $lucky_numbers|merge:[$val] }
              }
            }
            var.update $c { value = $c + 1 }
          }
        }
        var.update $r { value = $r + 1 }
      }
    }
  }
  
  response = $lucky_numbers
}
