// Combination Sum - Classic backtracking coding exercise
// Given an array of distinct integers (candidates) and a target integer (target),
// return a list of all unique combinations where the chosen numbers sum to target.
// The same number may be chosen from candidates unlimited times.
function "combination_sum" {
  description = "Finds all unique combinations that sum to target"
  
  input {
    int[] candidates { description = "Array of distinct integers to use" }
    int target { description = "Target sum to achieve" }
  }
  
  stack {
    // Sort candidates to help with duplicate avoidance and early termination
    var $sorted_candidates { 
      value = $input.candidates|sort 
    }
    
    // Results array to store all valid combinations
    var $results { value = [] }
    
    // Use iterative approach with a manual stack to simulate recursion
    // Each stack item contains: [current_sum, start_index, current_combination]
    var $stack { 
      value = [
        {
          sum: 0,
          start_idx: 0,
          combination: []
        }
      ]
    }
    
    // Process stack until empty
    while (($stack|count) > 0) {
      each {
        // Pop from stack
        array.pop $stack as $current
        
        var $current_sum { value = $current.sum }
        var $start_idx { value = $current.start_idx }
        var $current_combo { value = $current.combination }
        
        // Check if we found a valid combination
        conditional {
          if ($current_sum == $input.target) {
            // Found a valid combination - add to results
            array.push $results {
              value = $current_combo
            }
          }
          elseif ($current_sum < $input.target) {
            // Try adding each candidate from start_idx onwards
            var $i { value = $start_idx }
            
            while ($i < ($sorted_candidates|count)) {
              each {
                var $candidate { 
                  value = $sorted_candidates|get:$i 
                }
                var $new_sum { 
                  value = `$current_sum + $candidate` 
                }
                
                // Only continue if new_sum doesn't exceed target
                conditional {
                  if ($new_sum <= $input.target) {
                    // Create new combination by adding current candidate
                    var $new_combo { 
                      value = $current_combo|merge:[$candidate]
                    }
                    
                    // Push new state to stack
                    array.push $stack {
                      value = {
                        sum: $new_sum,
                        start_idx: $i,
                        combination: $new_combo
                      }
                    }
                  }
                }
                
                var.update $i { value = $i + 1 }
              }
            }
          }
        }
      }
    }
  }
  
  response = $results
}
