function "distribute_candies" {
  description = "Find the maximum number of different candy types Alice can eat"
  input {
    int[] candy_types
  }
  stack {
    // Calculate how many candies Alice can eat (n / 2)
    var $total_candies {
      value = ($input.candy_types|count)
    }
    var $can_eat {
      value = $total_candies / 2
    }
    
    // Find unique candy types using a simple approach
    // We'll track seen types in an array
    var $unique_types {
      value = []
    }
    
    foreach ($input.candy_types) {
      each as $candy {
        // Check if we've already seen this candy type
        var $already_seen { value = false }
        
        foreach ($unique_types) {
          each as $seen_type {
            conditional {
              if ($seen_type == $candy) {
                var.update $already_seen { value = true }
              }
            }
          }
        }
        
        // If not seen, add to unique types
        conditional {
          if ($already_seen == false) {
            array.push $unique_types {
              value = $candy
            }
          }
        }
      }
    }
    
    // Count unique types
    var $num_unique {
      value = ($unique_types|count)
    }
    
    // Result is the minimum of: unique types available vs candies she can eat
    conditional {
      if ($num_unique < $can_eat) {
        var $result { value = $num_unique }
      }
      else {
        var $result { value = $can_eat }
      }
    }
  }
  response = $result
}
