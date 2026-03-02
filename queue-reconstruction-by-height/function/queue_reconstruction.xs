// Queue Reconstruction by Height - Classic coding exercise
// Given an array of people where people[i] = [hi, ki],
// hi is the height of person i, and ki is the number of people in front of person i
// who have a height greater than or equal to hi.
// Reconstruct and return the queue that matches the given conditions.
function "queue_reconstruction" {
  description = "Reconstructs queue based on height and k values using greedy approach"

  input {
    json people
  }

  stack {
    // Get count of people
    var $n { value = $input.people|count }

    // Create array of indices for sorting
    var $indices { value = [] }
    var $i { value = 0 }
    while ($i < $n) {
      each {
        array.push $indices { value = $i }
        math.add $i { value = 1 }
      }
    }

    // Sort indices based on height descending, then k ascending
    // Using bubble sort approach since we need custom comparator
    var $sorted_indices { value = $indices }
    var $swapped { value = true }
    while ($swapped) {
      each {
        var $swapped { value = false }
        var $j { value = 0 }
        var $len_minus_1 { value = ($sorted_indices|count) - 1 }
        while ($j < $len_minus_1) {
          each {
            var $idx1 { value = $sorted_indices[$j] }
            var $idx2 { value = $sorted_indices[$j + 1] }
            var $person1 { value = $input.people[$idx1] }
            var $person2 { value = $input.people[$idx2] }

            // Compare: sort by height descending, then by k ascending
            var $should_swap { value = false }

            conditional {
              if ($person1[0] < $person2[0]) {
                // person1 is shorter, should come after (swap)
                var $should_swap { value = true }
              }
              elseif ($person1[0] == $person2[0] && $person1[1] > $person2[1]) {
                // Same height, but person1 has larger k, should come after
                var $should_swap { value = true }
              }
            }

            conditional {
              if ($should_swap) {
                // Swap elements
                var $temp { value = $sorted_indices[$j] }
                var $sorted_indices {
                  value = $sorted_indices|set:$j:$sorted_indices[$j + 1]
                }
                var $sorted_indices {
                  value = $sorted_indices|set:($j + 1):$temp
                }
                var $swapped { value = true }
              }
            }

            math.add $j { value = 1 }
          }
        }
      }
    }

    // Build sorted people array
    var $sorted { value = [] }
    foreach ($sorted_indices) {
      each as $idx {
        array.push $sorted { value = $input.people[$idx] }
      }
    }

    // Build result by inserting each person at their k position
    var $result { value = [] }

    foreach ($sorted) {
      each as $person {
        // Get k value (number of people to be in front)
        var $k { value = $person[1] }

        // Insert at position k using slice and merge
        var $before { value = $result|slice:0:$k }
        var $after { value = $result|slice:$k }
        var $result {
          value = $before|merge:[$person]|merge:$after
        }
      }
    }
  }

  response = $result
}
