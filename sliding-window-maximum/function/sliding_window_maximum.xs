function "sliding_window_maximum" {
  description = "Find the maximum value in each sliding window of size k"
  input {
    int[] nums { description = "Array of integers" }
    int k filters=min:1 { description = "Window size (must be at least 1)" }
  }
  stack {
    // Handle edge cases
    conditional {
      if (($input.nums|count) == 0 || $input.k == 0) {
        return { value = [] }
      }
    }

    conditional {
      if ($input.k > ($input.nums|count)) {
        return { value = [] }
      }
    }

    // Use a deque (simulated with array) to store indices
    // The deque will maintain indices of elements in decreasing order
    var $deque { value = [] }
    var $result { value = [] }
    var $n { value = $input.nums|count }

    // Process the first window
    for ($input.k) {
      each as $i {
        // Remove elements smaller than the current element from the back
        while (($deque|count) > 0 && $input.nums[($deque|last)] <= $input.nums[$i]) {
          each {
            var $deque { value = $deque|slice:0:(($deque|count) - 1) }
          }
        }
        // Add current index to deque
        var $deque { value = $deque|push:$i }
      }
    }

    // The first element in deque is the max of first window
    var $result { value = $result|push:$input.nums[($deque|first)] }

    // Slide the window
    var $window_start { value = 1 }
    var $window_end { value = $input.k }

    while ($window_end < $n) {
      each {
        // Remove indices that are out of this window
        while (($deque|count) > 0 && ($deque|first) < $window_start) {
          each {
            var $deque { value = $deque|slice:1 }
          }
        }

        // Remove elements smaller than the current element from the back
        while (($deque|count) > 0 && $input.nums[($deque|last)] <= $input.nums[$window_end]) {
          each {
            var $deque { value = $deque|slice:0:(($deque|count) - 1) }
          }
        }

        // Add current index to deque
        var $deque { value = $deque|push:$window_end }

        // The first element in deque is the max of current window
        var $result { value = $result|push:$input.nums[($deque|first)] }

        // Move window
        var $window_start { value = $window_start + 1 }
        var $window_end { value = $window_end + 1 }
      }
    }
  }
  response = $result
}
