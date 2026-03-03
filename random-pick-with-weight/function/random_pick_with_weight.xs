// Random Pick with Weight
// Given an array of positive integers w where w[i] represents the weight of index i,
// pick an index randomly based on the weights.
// The probability of picking index i is w[i] / sum(w)
function "random_pick_with_weight" {
  description = "Picks an index based on weighted probability"
  
  input {
    int[] weights { description = "Array of positive integers representing weights" }
    int num_picks?=1 { description = "Number of random picks to perform" }
  }
  
  stack {
    // Calculate prefix sums
    var $prefix_sums { value = [] }
    var $current_sum { value = 0 }
    
    foreach ($input.weights) {
      each as $weight {
        var $current_sum { value = $current_sum + $weight }
        var $prefix_sums {
          value = $prefix_sums|merge:[$current_sum]
        }
      }
    }
    
    var $total_sum { value = $current_sum }
    var $results { value = [] }
    var $pick_count { value = 0 }
    
    // Perform the requested number of picks
    while ($pick_count < $input.num_picks) {
      each {
        // Generate random number between 1 and total_sum
        security.random_number {
          min = 1
          max = $total_sum
        } as $random_val
        
        // Binary search to find the first prefix sum >= random_val
        var $left { value = 0 }
        var $right { value = $prefix_sums|count|subtract:1 }
        var $picked_index { value = 0 }
        
        while ($left <= $right) {
          each {
            var $mid { value = (($left + $right) / 2)|floor }
            var $mid_val { value = $prefix_sums|get:$mid }
            
            conditional {
              if ($mid_val < $random_val) {
                var $left { value = $mid + 1 }
              }
              else {
                var $picked_index { value = $mid }
                var $right { value = $mid - 1 }
              }
            }
          }
        }
        
        var $results {
          value = $results|merge:[$picked_index]
        }
        var $pick_count { value = $pick_count + 1 }
      }
    }
  }
  
  response = $results
}
