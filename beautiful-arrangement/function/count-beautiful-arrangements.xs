// Beautiful Arrangement - Count valid permutations using backtracking
function "count-beautiful-arrangements" {
  description = "Count the number of beautiful arrangements for n integers"
  
  input {
    int n { description = "The number of integers (1 to n) to arrange" }
  }
  
  stack {
    // Edge case: n = 0
    conditional {
      if ($input.n == 0) {
        return { value = 0 }
      }
    }
    
    // Initialize used array - track which numbers 1..n are used
    // $used[i] = true if number (i+1) is already placed
    var $used { value = [] }
    var $i { value = 0 }
    while ($i < $input.n) {
      each {
        var $used { value = $used ~ [false] }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Use iterative backtracking with explicit stack
    // Each stack element: { position, used_array }
    // We use position 1..n (1-indexed as per problem)
    var $stack { value = [{ pos: 1, used: $used }] }
    var $count { value = 0 }
    
    while (($stack|count) > 0) {
      each {
        // Pop from stack
        var $top { value = $stack|last }
        var $stack { value = $stack|slice:0:(($stack|count) - 1) }
        
        var $pos { value = $top.pos }
        var $curr_used { value = $top.used }
        
        conditional {
          // Base case: all positions filled
          if ($pos > $input.n) {
            var.update $count { value = $count + 1 }
          }
          else {
            // Try each number 1..n at current position
            var $num { value = $input.n }
            while ($num >= 1) {
              each {
                var $idx { value = $num - 1 }
                var $is_used { value = $curr_used|get:$idx }
                
                // Check if number is not used and satisfies beautiful condition
                // Condition: num % pos == 0 OR pos % num == 0
                var $cond1 { value = ($num % $pos) == 0 }
                var $cond2 { value = ($pos % $num) == 0 }
                
                conditional {
                  if ((!$is_used) && ($cond1 || $cond2)) {
                    // Mark as used and push to stack
                    var $new_used { value = $curr_used|set:$idx:true }
                    var $new_state { value = { pos: ($pos + 1), used: $new_used } }
                    var $stack { value = $stack ~ [$new_state] }
                  }
                }
                
                var.update $num { value = $num - 1 }
              }
            }
          }
        }
      }
    }
  }
  
  response = $count
}
