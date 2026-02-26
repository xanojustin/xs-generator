// Baseball Game - Stack-based scoring problem
// Process operations to calculate total score
function "calculate_score" {
  description = "Calculates total score from baseball game operations"
  
  input {
    text[] operations { description = "Array of operations: integers, 'C', 'D', or '+'" }
  }
  
  stack {
    var $scores { value = [] }
    
    foreach ($input.operations) {
      each as $op {
        conditional {
          // "C" - Invalidate previous score
          if ($op == "C") {
            // Remove last score
            var $new_scores { value = [] }
            var $idx { value = 0 }
            foreach ($scores) {
              each as $score {
                conditional {
                  if ($idx < ($scores|count) - 1) {
                    var $new_scores { value = $new_scores|merge:[$score] }
                  }
                }
                var.update $idx { value = $idx + 1 }
              }
            }
            var $scores { value = $new_scores }
          }
          // "D" - Double previous score
          elseif ($op == "D") {
            var $last { value = $scores|last }
            var $doubled { value = $last * 2 }
            var $scores { value = $scores|merge:[$doubled] }
          }
          // "+" - Sum of previous two scores
          elseif ($op == "+") {
            var $count { value = $scores|count }
            var $second_last_idx { value = $count - 2 }
            var $last_idx { value = $count - 1 }
            var $second_last { value = $scores[$second_last_idx] }
            var $last { value = $scores[$last_idx] }
            var $sum { value = $second_last + $last }
            var $scores { value = $scores|merge:[$sum] }
          }
          // Integer - Add the score
          else {
            var $num { value = $op|to_int }
            var $scores { value = $scores|merge:[$num] }
          }
        }
      }
    }
    
    // Calculate total
    var $total { value = 0 }
    foreach ($scores) {
      each as $score {
        var.update $total { value = $total + $score }
      }
    }
  }
  
  response = $total
}
