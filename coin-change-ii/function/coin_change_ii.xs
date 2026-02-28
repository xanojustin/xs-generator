function "coin_change_ii" {
  description = "Count the number of ways to make change for a given amount using given coin denominations"
  input {
    int amount filters=min:0
    int[] coins
  }
  stack {
    // Edge case: amount is 0, there's one way (use no coins)
    conditional {
      if ($input.amount == 0) {
        return { value = 1 }
      }
    }

    // Edge case: no coins provided
    conditional {
      if (($input.coins|count) == 0) {
        return { value = 0 }
      }
    }

    // Initialize DP array: dp[i] = number of ways to make amount i
    // Start with array of zeros, size amount + 1
    var $dp {
      value = []
    }

    // Fill dp array with zeros
    for ($input.amount + 1) {
      each as $i {
        var.update $dp {
          value = $dp|append:0
        }
      }
    }

    // Base case: one way to make amount 0 (use no coins)
    var.update $dp {
      value = $dp|set:"0":1
    }

    // For each coin, update dp array
    foreach ($input.coins) {
      each as $coin {
        // Skip invalid coins (non-positive)
        conditional {
          if ($coin <= 0) {
            continue
          }
        }

        // For amounts from coin to target amount
        var $j {
          value = $coin
        }

        while ($j <= $input.amount) {
          each {
            // Get current dp[j] value
            var $current_val {
              value = $dp|get:($j|to_text)
            }

            // Get dp[j - coin] value
            var $prev_index {
              value = $j - $coin
            }
            var $prev_val {
              value = $dp|get:($prev_index|to_text)
            }

            // dp[j] += dp[j - coin]
            var $new_val {
              value = $current_val + $prev_val
            }

            var.update $dp {
              value = $dp|set:($j|to_text):$new_val
            }

            // Increment j
            var.update $j {
              value = $j + 1
            }
          }
        }
      }
    }

    // Return the number of ways to make the target amount
    var $result {
      value = $dp|get:($input.amount|to_text)
    }
  }
  response = $result
}
