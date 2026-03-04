function "count_number_of_teams" {
  description = "Count the number of valid teams of 3 soldiers with strictly increasing or decreasing ratings"
  input {
    int[] ratings
  }
  stack {
    var $n { value = $input.ratings|count }
    var $count { value = 0 }
    
    // For each possible middle soldier j
    for ($n) {
      each as $j {
        // Only process if j is at least 1 and at most n-2 (need at least one on each side)
        conditional {
          if ($j > 0 && $j < $n - 1) {
            var $left_smaller { value = 0 }
            var $left_larger { value = 0 }
            var $right_smaller { value = 0 }
            var $right_larger { value = 0 }
            
            // Get rating at position j
            var $rating_j { value = $input.ratings|get:($j|to_text) }
            
            // Count soldiers to the left of j
            for ($j) {
              each as $i {
                var $rating_i { value = $input.ratings|get:($i|to_text) }
                conditional {
                  if ($rating_i < $rating_j) {
                    var.update $left_smaller { value = $left_smaller + 1 }
                  }
                  elseif ($rating_i > $rating_j) {
                    var.update $left_larger { value = $left_larger + 1 }
                  }
                }
              }
            }
            
            // Count soldiers to the right of j
            var $start { value = $j + 1 }
            for ($n - $start) {
              each as $idx {
                var $k { value = $start + $idx }
                var $rating_k { value = $input.ratings|get:($k|to_text) }
                conditional {
                  if ($rating_k < $rating_j) {
                    var.update $right_smaller { value = $right_smaller + 1 }
                  }
                  elseif ($rating_k > $rating_j) {
                    var.update $right_larger { value = $right_larger + 1 }
                  }
                }
              }
            }
            
            // Increasing teams: left_smaller * right_larger
            // Decreasing teams: left_larger * right_smaller
            var.update $count { value = $count + ($left_smaller * $right_larger) + ($left_larger * $right_smaller) }
          }
        }
      }
    }
  }
  response = $count
}
