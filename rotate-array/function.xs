function "rotate_array" {
  description = "Rotate an array to the right by k steps"
  input {
    int[] nums {
      description = "The array of integers to rotate"
    }
    int k filters=min:0 {
      description = "Number of steps to rotate right (must be >= 0)"
    }
  }
  stack {
    // Handle empty array case
    conditional {
      if (($input.nums|count) == 0) {
        var $result { value = [] }
      }
      else {
        var $length { value = $input.nums|count }
        var $effective_k { value = $input.k % $length }

        // If effective rotation is 0, return original array
        conditional {
          if ($effective_k == 0) {
            var $result { value = $input.nums }
          }
          else {
            // Calculate split point: last k elements go to front
            var $split_point { value = $length - $effective_k }

            // Get the two parts of the array
            var $first_part { value = $input.nums|slice:0:$split_point }
            var $second_part { value = $input.nums|slice:$split_point:$length }

            // Combine: second_part + first_part
            var $result { value = $second_part|merge:$first_part }
          }
        }
      }
    }
  }
  response = $result
}
