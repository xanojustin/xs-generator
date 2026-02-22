// Insertion Sort - Classic sorting algorithm
// Sorts an array of integers using the insertion sort algorithm
function "insertion_sort" {
  description = "Sorts an array of integers using insertion sort algorithm"

  input {
    int[] numbers { description = "Array of integers to sort" }
  }

  stack {
    // Create a copy of the input array to avoid mutating the original
    var $arr { value = $input.numbers }
    var $n { value = $arr|count }

    // If array has 0 or 1 elements, it's already sorted
    conditional {
      if ($n <= 1) {
        return { value = $arr }
      }
    }

    // Start from the second element (index 1)
    var $i { value = 1 }

    while ($i < $n) {
      each {
        // Store the current element to be inserted
        var $key { value = $arr[$i] }
        var $j { value = $i - 1 }

        // Move elements greater than key one position ahead
        while ($j >= 0 && $arr[$j] > $key) {
          each {
            var.update $arr[$j + 1] { value = $arr[$j] }
            var.update $j { value = $j - 1 }
          }
        }

        // Place the key at its correct position
        var.update $arr[$j + 1] { value = $key }

        // Move to next element
        var.update $i { value = $i + 1 }
      }
    }
  }

  response = $arr
}
