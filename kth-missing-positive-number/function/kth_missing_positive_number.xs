// Kth Missing Positive Number - Binary Search Exercise
// Given a sorted array of positive integers and an integer k,
// find the kth positive integer that is missing from this array.
// Uses binary search for O(log n) time complexity.
function "kth_missing_positive_number" {
  description = "Finds the kth missing positive integer from a sorted array"

  input {
    int[] arr { description = "Sorted array of positive integers (strictly increasing)" }
    int k { description = "The kth missing positive integer to find" }
  }

  stack {
    // The number of missing integers before arr[i] is: arr[i] - i - 1
    // We need to find the smallest index where missing_count >= k
    
    var $left { value = 0 }
    var $right { value = ($input.arr|count) - 1 }
    var $result { value = 0 }
    var $n { value = $input.arr|count }

    // Edge case: if k is larger than all missing numbers in the array
    // The missing count at the last element is: arr[n-1] - n
    // If k > missing_count at last element, answer is arr[n-1] + (k - missing_count)
    
    // Binary search to find the position
    while ($left <= $right) {
      each {
        var $mid { value = $left + (($right - $left) / 2) }
        var $missing_count { value = $input.arr[$mid] - $mid - 1 }

        conditional {
          // If missing count at mid is less than k, search right half
          if ($missing_count < $input.k) {
            var $left { value = $mid + 1 }
          }
          // Otherwise, search left half
          else {
            var $right { value = $mid - 1 }
          }
        }
      }
    }

    // After binary search, left is the index where the kth missing number would be
    // The kth missing number is: left + k
    // (because there are 'left' elements in array before position left,
    // and we need k more to reach the kth missing number)
    var.update $result { value = $left + $input.k }
  }

  response = $result
}
