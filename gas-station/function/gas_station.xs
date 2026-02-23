// Gas Station - Greedy algorithm problem
// Find the starting gas station index to complete a circuit around a circular route
// Returns -1 if it's impossible to complete the circuit
function "gas_station" {
  description = "Finds the starting gas station index to complete a circuit"

  input {
    int[] gas { description = "Amount of gas at each station" }
    int[] cost { description = "Cost of gas to travel to next station" }
  }

  stack {
    // Calculate total gas and total cost
    var $total_gas { value = 0 }
    var $total_cost { value = 0 }
    var $n { value = $input.gas|count }
    var $i { value = 0 }

    // Sum up total gas and total cost
    foreach ($input.gas) {
      each as $g {
        var $total_gas { value = $total_gas + $g }
        var $c { value = $input.cost|get:$i }
        var $total_cost { value = $total_cost + $c }
        var $i { value = $i + 1 }
      }
    }

    // If total gas < total cost, impossible to complete circuit
    conditional {
      if ($total_gas < $total_cost) {
        var $result { value = -1 }
      }
      else {
        // Greedy approach: find valid starting station
        var $tank { value = 0 }
        var $start { value = 0 }
        var $index { value = 0 }

        foreach ($input.gas) {
          each as $g {
            var $c { value = $input.cost|get:$index }
            var $tank { value = $tank + $g - $c }

            // If tank goes negative, can't start from current start
            // Try next station as new start
            conditional {
              if ($tank < 0) {
                var $start { value = $index + 1 }
                var $tank { value = 0 }
              }
            }

            var $index { value = $index + 1 }
          }
        }

        var $result { value = $start }
      }
    }
  }

  response = $result
}
