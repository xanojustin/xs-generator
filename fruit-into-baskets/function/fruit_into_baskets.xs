// Fruit Into Baskets - Sliding Window exercise
// You have two baskets and can pick fruits from a row of trees.
// Each tree produces one type of fruit.
// You want to collect the maximum number of fruits, but you can only
// carry at most two different types of fruits in your baskets.
// Return the maximum number of fruits you can collect.
function "fruit_into_baskets" {
  description = "Finds maximum fruits that can be collected with at most 2 types"

  input {
    int[] fruits { description = "Array where each element represents a fruit type on a tree" }
  }

  stack {
    // Track count of each fruit type in current window
    var $basket { value = {} }
    var $left { value = 0 }
    var $max_fruits { value = 0 }
    var $fruit_types { value = 0 }

    // Iterate through trees with right pointer
    var $right { value = 0 }

    while ($right < ($input.fruits|count)) {
      each {
        // Get current fruit type
        var $current_fruit { value = $input.fruits[$right] }
        var $fruit_key { value = $current_fruit|to_text }

        // Get current count for this fruit type (0 if not present)
        var $prev_count { value = 0 }
        conditional {
          if ($basket|has:$fruit_key) {
            var $prev_count { value = $basket|get:$fruit_key }
          }
        }

        // Check if this is a new fruit type (count was 0)
        conditional {
          if ($prev_count == 0) {
            var $fruit_types { value = $fruit_types + 1 }
          }
        }

        // Add fruit to basket (increment count)
        var $basket {
          value = $basket|set:$fruit_key:($prev_count + 1)
        }

        // If we have more than 2 types, shrink window from left
        while ($fruit_types > 2) {
          each {
            var $left_fruit { value = $input.fruits[$left] }
            var $left_key { value = $left_fruit|to_text }
            var $left_count { value = $basket|get:$left_key }

            // Decrement count for left fruit
            var $new_left_count { value = $left_count - 1 }
            var $basket {
              value = $basket|set:$left_key:$new_left_count
            }

            // If count becomes 0, we lost a fruit type
            conditional {
              if ($new_left_count == 0) {
                var $fruit_types { value = $fruit_types - 1 }
              }
            }

            var.update $left { value = $left + 1 }
          }
        }

        // Update max fruits collected
        var $window_size { value = $right - $left + 1 }
        conditional {
          if ($window_size > $max_fruits) {
            var $max_fruits { value = $window_size }
          }
        }

        var.update $right { value = $right + 1 }
      }
    }
  }

  response = $max_fruits
}
