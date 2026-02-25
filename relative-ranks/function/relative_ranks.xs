function "relative_ranks" {
  description = "Assign ranks to scores. Top 3 get medals, rest get numeric ranks."
  input {
    int[] scores
  }
  stack {
    // Handle empty input
    conditional {
      if (($input.scores|count) == 0) {
        return { value = [] }
      }
    }

    // Create array of {score, index} objects to track original positions
    var $indexed_scores { value = [] }
    var $idx { value = 0 }
    
    foreach ($input.scores) {
      each as $score {
        var $item {
          value = { score: $score, index: $idx }
        }
        var.update $indexed_scores {
          value = $indexed_scores|push:$item
        }
        var.update $idx { value = $idx + 1 }
      }
    }

    // Sort by score descending (higher score = better rank)
    // We'll use a simple bubble sort since XanoScript doesn't have a sort filter
    var $n { value = $indexed_scores|count }
    var $sorted { value = $indexed_scores }
    
    for ($n) {
      each as $i {
        var $inner_n { value = $n - $i - 1 }
        conditional {
          if ($inner_n > 0) {
            var $j { value = 0 }
            for ($inner_n) {
              each as $unused {
                var $current { value = $sorted|get:$j }
                var $next_idx { value = $j + 1 }
                var $next { value = $sorted|get:$next_idx }
                
                conditional {
                  if ($current.score < $next.score) {
                    // Swap elements
                    var $temp { value = $current }
                    var.update $sorted { value = $sorted|set:$j:$next }
                    var.update $sorted { value = $sorted|set:$next_idx:$temp }
                  }
                }
                
                var.update $j { value = $j + 1 }
              }
            }
          }
        }
      }
    }

    // Create result array with ranks
    var $result { value = [] }
    // Initialize result array with empty strings
    for (($input.scores|count)) {
      each as $unused {
        var.update $result { value = $result|push:"" }
      }
    }

    // Assign ranks based on sorted order
    var $rank_idx { value = 0 }
    foreach ($sorted) {
      each as $item {
        var $rank_str { value = "" }
        
        conditional {
          if ($rank_idx == 0) {
            var.update $rank_str { value = "Gold Medal" }
          }
          elseif ($rank_idx == 1) {
            var.update $rank_str { value = "Silver Medal" }
          }
          elseif ($rank_idx == 2) {
            var.update $rank_str { value = "Bronze Medal" }
          }
          else {
            var.update $rank_str { value = ($rank_idx + 1)|to_text }
          }
        }

        // Place rank at original index
        var.update $result { value = $result|set:$item.index:$rank_str }
        var.update $rank_idx { value = $rank_idx + 1 }
      }
    }
  }
  response = $result
}
