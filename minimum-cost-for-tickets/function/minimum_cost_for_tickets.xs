// Minimum Cost For Tickets - Dynamic Programming Exercise
// Given travel days and ticket costs, find the minimum cost to travel all days
// Three ticket types: 1-day, 7-day, and 30-day passes
function "minimum_cost_for_tickets" {
  description = "Calculates minimum cost to travel on all given days"

  input {
    int[] days { description = "Array of travel days (1-365, sorted in increasing order)" }
    int[] costs { description = "Array of 3 costs: [1-day pass, 7-day pass, 30-day pass]" }
  }

  stack {
    // Handle edge case: no travel days
    conditional {
      if (($input.days|count) == 0) {
        return { value = 0 }
      }
    }

    // Get the last day we need to cover
    var $last_day { value = $input.days|last }

    // DP array: dp[i] = minimum cost to cover up to day i
    // We'll use an array where index represents the day
    var $dp { value = [] }
    var $i { value = 0 }

    // Initialize dp array with 0s up to last_day + 1
    while ($i <= $last_day) {
      each {
        var $dp { value = $dp|merge:[0] }
        var.update $i { value = $i + 1 }
      }
    }

    // Create a set of travel days for O(1) lookup
    // We'll use a boolean array where is_travel_day[day] = true if we travel that day
    var $is_travel_day { value = [] }
    var $j { value = 0 }

    while ($j <= $last_day) {
      each {
        var $is_travel_day { value = $is_travel_day|merge:[false] }
        var.update $j { value = $j + 1 }
      }
    }

    // Mark travel days
    foreach ($input.days) {
      each as $day {
        var.update $is_travel_day[$day] { value = true }
      }
    }

    // Fill DP table day by day
    var $current_day { value = 1 }

    while ($current_day <= $last_day) {
      each {
        conditional {
          // If not a travel day, cost is same as previous day
          if (!$is_travel_day[$current_day]) {
            var.update $dp[$current_day] { value = $dp[$current_day - 1] }
          }
          else {
            // It's a travel day - calculate minimum cost
            // Option 1: Buy 1-day pass
            var $cost_1_day { value = $dp[$current_day - 1] + $input.costs[0] }

            // Option 2: Buy 7-day pass (covers from day-6 to day)
            var $cost_7_day { value = $input.costs[1] }
            conditional {
              if ($current_day > 7) {
                var.update $cost_7_day { value = $dp[$current_day - 7] + $input.costs[1] }
              }
            }

            // Option 3: Buy 30-day pass (covers from day-29 to day)
            var $cost_30_day { value = $input.costs[2] }
            conditional {
              if ($current_day > 30) {
                var.update $cost_30_day { value = $dp[$current_day - 30] + $input.costs[2] }
              }
            }

            // Take the minimum of all options
            var $min_cost { value = $cost_1_day }
            conditional {
              if ($cost_7_day < $min_cost) {
                var.update $min_cost { value = $cost_7_day }
              }
            }
            conditional {
              if ($cost_30_day < $min_cost) {
                var.update $min_cost { value = $cost_30_day }
              }
            }

            var.update $dp[$current_day] { value = $min_cost }
          }
        }

        var.update $current_day { value = $current_day + 1 }
      }
    }

    return { value = $dp[$last_day] }
  }

  response = $response
}
