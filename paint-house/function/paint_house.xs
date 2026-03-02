function "paint_house" {
  description = "Calculate minimum cost to paint houses with no two adjacent houses having the same color"
  input {
    json costs
  }
  stack {
    // costs[i][j] = cost to paint house i with color j
    // We need to find minimum cost where no two adjacent houses share the same color
    
    var $num_houses {
      value = ($input.costs|count)
    }
    
    // Handle edge case: no houses
    conditional {
      if ($num_houses == 0) {
        return { value = 0 }
      }
    }
    
    // Get number of colors (assuming all houses have same number of color options)
    var $first_house {
      value = $input.costs|first
    }
    var $num_colors {
      value = ($first_house|count)
    }
    
    // Handle edge case: one house - just pick the minimum cost color
    conditional {
      if ($num_houses == 1) {
        var $min_cost {
          value = ($first_house|sort)|first
        }
        return { value = $min_cost }
      }
    }
    
    // dp[i][j] = minimum cost to paint houses 0..i where house i is painted color j
    // We use two arrays to save space: previous and current
    
    // Initialize dp with the first house costs
    var $prev_dp {
      value = $first_house
    }
    
    // Iterate through remaining houses
    var $house_idx {
      value = 1
    }
    
    while ($house_idx < $num_houses) {
      each {
        // Get costs for current house
        var $current_house_costs {
          value = $input.costs[$house_idx]
        }
        
        // Calculate dp for each color
        var $curr_dp {
          value = []
        }
        
        var $color_idx {
          value = 0
        }
        
        while ($color_idx < $num_colors) {
          each {
            // Find minimum cost from previous house with different color
            var $min_prev_cost {
              value = null
            }
            
            var $prev_color_idx {
              value = 0
            }
            
            while ($prev_color_idx < $num_colors) {
              each {
                conditional {
                  if ($prev_color_idx != $color_idx) {
                    var $prev_cost {
                      value = $prev_dp[$prev_color_idx]
                    }
                    conditional {
                      if ($min_prev_cost == null || $prev_cost < $min_prev_cost) {
                        var $min_prev_cost {
                          value = $prev_cost
                        }
                      }
                    }
                  }
                }
                var $prev_color_idx {
                  value = $prev_color_idx + 1
                }
              }
            }
            
            // Current cost = min previous cost + current house cost
            var $current_cost {
              value = $min_prev_cost + $current_house_costs[$color_idx]
            }
            var $curr_dp {
              value = $curr_dp|append:$current_cost
            }
            
            var $color_idx {
              value = $color_idx + 1
            }
          }
        }
        
        // Update prev_dp for next iteration
        var $prev_dp {
          value = $curr_dp
        }
        
        var $house_idx {
          value = $house_idx + 1
        }
      }
    }
    
    // Find minimum cost in the last dp array
    var $result {
      value = ($prev_dp|sort)|first
    }
    
    return { value = $result }
  }
  response = 0
}
