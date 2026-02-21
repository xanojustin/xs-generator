function "majority_element" {
  description = "Find the majority element (appears more than n/2 times) using Boyer-Moore voting algorithm"
  input {
    int[] nums { description = "Array of integers" }
  }
  stack {
    // Handle edge case of empty array
    precondition (($input.nums|count) > 0) {
      error_type = "standard"
      error = "Input array cannot be empty"
    }

    // Boyer-Moore Voting Algorithm
    // Phase 1: Find candidate
    var $candidate {
      value = null
    }
    var $count {
      value = 0
    }

    foreach ($input.nums) {
      each as $num {
        conditional {
          if ($count == 0) {
            var.update $candidate {
              value = $num
            }
            var.update $count {
              value = 1
            }
          }
          elseif ($num == $candidate) {
            var.update $count {
              value = $count + 1
            }
          }
          else {
            var.update $count {
              value = $count - 1
            }
          }
        }
      }
    }

    // Phase 2: Verify the candidate appears more than n/2 times
    var $verify_count {
      value = 0
    }
    var $total {
      value = $input.nums|count
    }

    foreach ($input.nums) {
      each as $num {
        conditional {
          if ($num == $candidate) {
            var.update $verify_count {
              value = $verify_count + 1
            }
          }
        }
      }
    }

    // Check if candidate is actually a majority
    var $is_majority {
      value = ($verify_count * 2) > $total
    }

    conditional {
      if (!$is_majority) {
        var $candidate {
          value = null
        }
      }
    }
  }
  response = $candidate
}
