// Find Median from Data Stream
// Given a stream of integers, calculate the median after each number is added
// The median is the middle value in an ordered integer list
// If the list length is even, the median is the average of the two middle values
function "find_median_from_data_stream" {
  description = "Calculates running median after each number is added to a stream"

  input {
    int[] stream { description = "Array of integers representing the data stream" }
  }

  stack {
    var $medians { value = [] }
    var $current_stream { value = [] }
    var $i { value = 0 }
    var $n { value = $input.stream|count }

    while ($i < $n) {
      each {
        // Add current number to the stream
        var $current_stream {
          value = $current_stream ~ [$input.stream[$i]]
        }

        // Calculate median of current_stream
        // First, we need to sort the current stream
        function.run "find_median_sorted" {
          input = { arr: $current_stream }
        } as $median_result

        var $medians {
          value = $medians ~ [$median_result]
        }

        var.update $i { value = $i + 1 }
      }
    }
  }

  response = $medians
}
