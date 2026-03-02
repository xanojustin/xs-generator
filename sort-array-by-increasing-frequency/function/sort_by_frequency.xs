// Sort Array by Increasing Frequency
// Sorts elements by frequency (ascending), and for ties, by value (descending)
function "sort_by_frequency" {
  description = "Sorts array by increasing frequency of elements. For ties, sorts by value in descending order."

  input {
    int[] nums { description = "Array of integers to sort" }
  }

  stack {
    // Edge case: empty or single element array
    conditional {
      if (($input.nums|count) <= 1) {
        return { value = $input.nums }
      }
    }

    // Step 1: Count frequency of each number
    var $freq_map { value = {} }
    foreach ($input.nums) {
      each as $num {
        var $num_key {
          value = $num|to_text
        }
        conditional {
          if ($freq_map|has:$num_key) {
            var $current_freq {
              value = $freq_map|get:$num_key
            }
            var $new_freq {
              value = $current_freq + 1
            }
            var.update $freq_map {
              value = $freq_map|set:$num_key:$new_freq
            }
          }
          else {
            var.update $freq_map {
              value = $freq_map|set:$num_key:1
            }
          }
        }
      }
    }

    // Step 2: Create array of {num, freq} objects for sorting
    var $items { value = [] }
    var $keys {
      value = $freq_map|keys
    }
    foreach ($keys) {
      each as $key {
        var $num_val {
          value = $key|to_int
        }
        var $freq_val {
          value = $freq_map|get:$key
        }
        var $item {
          value = { num: $num_val, freq: $freq_val }
        }
        var.update $items {
          value = $items|merge:[$item]
        }
      }
    }

    // Step 3: Sort by frequency ascending, then by value descending using bubble sort
    var $n { value = $items|count }
    var $i { value = 0 }
    while ($i < $n - 1) {
      each {
        var $j { value = 0 }
        while ($j < $n - $i - 1) {
          each {
            var $item_a { value = $items[$j] }
            var $item_b { value = $items[$j + 1] }
            
            // Check if we need to swap
            // Sort by freq ascending, then by num descending
            var $should_swap { value = false }
            
            conditional {
              // If freq_a > freq_b, swap (ascending order)
              if ($item_a.freq > $item_b.freq) {
                var $should_swap { value = true }
              }
              // If frequencies are equal, check values (descending order)
              elseif ($item_a.freq == $item_b.freq && $item_a.num < $item_b.num) {
                var $should_swap { value = true }
              }
            }
            
            conditional {
              if ($should_swap) {
                // Swap items
                var $temp { value = $item_a }
                var.update $items[$j] { value = $item_b }
                var.update $items[$j + 1] { value = $temp }
              }
            }
            
            var.update $j { value = $j + 1 }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }

    // Step 4: Build result array by expanding frequencies
    var $result { value = [] }
    foreach ($items) {
      each as $sorted_item {
        var $k { value = 0 }
        while ($k < $sorted_item.freq) {
          each {
            var.update $result {
              value = $result|merge:[$sorted_item.num]
            }
            var.update $k { value = $k + 1 }
          }
        }
      }
    }
  }

  response = $result
}
