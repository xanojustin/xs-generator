function "pacific_atlantic_water_flow" {
  description = "Find cells where water can flow to both Pacific and Atlantic oceans"
  input {
    json heights {
      description = "m x n matrix of non-negative integers representing cell heights"
    }
  }
  stack {
    // Get matrix dimensions
    var $rows { value = $input.heights|count }
    var $cols { value = ($input.heights|first)|count }
    
    // Edge case: empty matrix
    conditional {
      if ($rows == 0 || $cols == 0) {
        return { value = [] }
      }
    }
    
    // Initialize visited matrices for Pacific and Atlantic
    var $pacific { value = [] }
    var $atlantic { value = [] }
    
    // Initialize 2D arrays with false values
    for ($rows) {
      each as $r {
        var $p_row { value = [] }
        var $a_row { value = [] }
        for ($cols) {
          each as $c {
            var $p_row { value = $p_row|push:false }
            var $a_row { value = $a_row|push:false }
          }
        }
        var $pacific { value = $pacific|push:$p_row }
        var $atlantic { value = $atlantic|push:$a_row }
      }
    }
    
    // DFS function to mark reachable cells
    // We'll implement DFS iteratively using a stack
    
    // Process Pacific ocean cells (top row and left column)
    for ($cols) {
      each as $c {
        // Mark top row as Pacific reachable
        var $pacific { value = $pacific|set:0|set:$c:true }
      }
    }
    for ($rows) {
      each as $r {
        // Mark left column as Pacific reachable  
        var $pacific { value = $pacific|set:$r|set:0:true }
      }
    }
    
    // Process Atlantic ocean cells (bottom row and right column)
    var $last_row { value = $rows - 1 }
    var $last_col { value = $cols - 1 }
    for ($cols) {
      each as $c {
        // Mark bottom row as Atlantic reachable
        var $atlantic { value = $atlantic|set:$last_row|set:$c:true }
      }
    }
    for ($rows) {
      each as $r {
        // Mark right column as Atlantic reachable
        var $atlantic { value = $atlantic|set:$r|set:$last_col:true }
      }
    }
    
    // Perform DFS from Pacific borders
    var $pacific_stack { value = [] }
    for ($cols) {
      each as $c {
        var $pacific_stack { value = $pacific_stack|push:{row: 0, col: $c} }
      }
    }
    for ($rows) {
      each as $r {
        conditional {
          if ($r > 0) {
            var $pacific_stack { value = $pacific_stack|push:{row: $r, col: 0} }
          }
        }
      }
    }
    
    // DFS for Pacific
    while (($pacific_stack|count) > 0) {
      each {
        var $cell { value = $pacific_stack|last }
        var $pacific_stack { value = $pacific_stack|slice:0:-1 }
        var $r { value = $cell|get:"row" }
        var $c { value = $cell|get:"col" }
        var $curr_height { value = ($input.heights|get:$r)|get:$c }
        
        // Check all 4 directions
        var $directions { value = [{r: -1, c: 0}, {r: 1, c: 0}, {r: 0, c: -1}, {r: 0, c: 1}] }
        foreach ($directions) {
          each as $dir {
            var $nr { value = $r + ($dir|get:"r") }
            var $nc { value = $c + ($dir|get:"c") }
            
            // Check bounds
            conditional {
              if ($nr >= 0 && $nr < $rows && $nc >= 0 && $nc < $cols) {
                var $next_height { value = ($input.heights|get:$nr)|get:$nc }
                var $is_visited { value = ($pacific|get:$nr)|get:$nc }
                
                conditional {
                  if (!$is_visited && $next_height >= $curr_height) {
                    var $pacific { value = $pacific|set:$nr|set:$nc:true }
                    var $pacific_stack { value = $pacific_stack|push:{row: $nr, col: $nc} }
                  }
                }
              }
            }
          }
        }
      }
    }
    
    // Perform DFS from Atlantic borders
    var $atlantic_stack { value = [] }
    for ($cols) {
      each as $c {
        var $atlantic_stack { value = $atlantic_stack|push:{row: $last_row, col: $c} }
      }
    }
    for ($rows) {
      each as $r {
        conditional {
          if ($r < $last_row) {
            var $atlantic_stack { value = $atlantic_stack|push:{row: $r, col: $last_col} }
          }
        }
      }
    }
    
    // DFS for Atlantic
    while (($atlantic_stack|count) > 0) {
      each {
        var $cell { value = $atlantic_stack|last }
        var $atlantic_stack { value = $atlantic_stack|slice:0:-1 }
        var $r { value = $cell|get:"row" }
        var $c { value = $cell|get:"col" }
        var $curr_height { value = ($input.heights|get:$r)|get:$c }
        
        // Check all 4 directions
        var $directions { value = [{r: -1, c: 0}, {r: 1, c: 0}, {r: 0, c: -1}, {r: 0, c: 1}] }
        foreach ($directions) {
          each as $dir {
            var $nr { value = $r + ($dir|get:"r") }
            var $nc { value = $c + ($dir|get:"c") }
            
            // Check bounds
            conditional {
              if ($nr >= 0 && $nr < $rows && $nc >= 0 && $nc < $cols) {
                var $next_height { value = ($input.heights|get:$nr)|get:$nc }
                var $is_visited { value = ($atlantic|get:$nr)|get:$nc }
                
                conditional {
                  if (!$is_visited && $next_height >= $curr_height) {
                    var $atlantic { value = $atlantic|set:$nr|set:$nc:true }
                    var $atlantic_stack { value = $atlantic_stack|push:{row: $nr, col: $nc} }
                  }
                }
              }
            }
          }
        }
      }
    }
    
    // Find cells that can reach both oceans
    var $result { value = [] }
    for ($rows) {
      each as $r {
        for ($cols) {
          each as $c {
            var $p_reach { value = ($pacific|get:$r)|get:$c }
            var $a_reach { value = ($atlantic|get:$r)|get:$c }
            
            conditional {
              if ($p_reach && $a_reach) {
                var $result { value = $result|push:{row: $r, col: $c} }
              }
            }
          }
        }
      }
    }
  }
  response = $result
}
