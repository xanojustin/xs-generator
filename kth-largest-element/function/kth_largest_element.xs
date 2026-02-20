// Kth Largest Element - Classic coding exercise
// Finds the kth largest element in an unsorted array
function "kth_largest_element" {
  description = "Finds the kth largest element in an unsorted array"

  input {
    int[] nums { description = "Array of integers" }
    int k { description = "The kth position to find (1 = largest, 2 = second largest, etc.)" }
  }

  stack {
    // Validate k is within bounds using precondition
    var $n { value = $input.nums|count }

    precondition ($input.k >= 1 && $input.k <= $n) {
      error_type = "standard"
      error = "k must be between 1 and " ~ ($n|to_text) ~ " (array length)"
    }

    // Sort the array in descending order using bubble sort
    var $arr { value = $input.nums }
    var $length { value = $n }
    var $i { value = 0 }

    // Outer loop for bubble sort
    while ($i < $length - 1) {
      each {
        var $j { value = 0 }

        // Inner loop - compare and swap for descending order
        while ($j < $length - $i - 1) {
          each {
            conditional {
              // For descending order, swap if current < next
              if ($arr[$j] < $arr[$j + 1]) {
                var $temp { value = $arr[$j] }
                var.update $arr[$j] { value = $arr[$j + 1] }
                var.update $arr[$j + 1] { value = $temp }
              }
            }
            var.update $j { value = $j + 1 }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }

    // The kth largest element is at index k-1 (0-indexed)
    var $result { value = $arr[$input.k - 1] }
  }

  response = $result
}
