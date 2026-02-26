function "radix_sort" {
  description = "Sorts an array of non-negative integers using radix sort (LSD - least significant digit first)"
  input {
    int[] numbers
  }
  stack {
    // Handle edge cases: empty array or single element
    conditional {
      if (($input.numbers|count) <= 1) {
        return { value = $input.numbers }
      }
    }

    // Find the maximum number to determine the number of digits
    var $max_num { value = $input.numbers|first }
    foreach ($input.numbers) {
      each as $num {
        conditional {
          if ($num > $max_num) {
            var.update $max_num { value = $num }
          }
        }
      }
    }

    // Initialize the array to be sorted (we'll work with a copy)
    var $current_array { value = $input.numbers }
    var $exp { value = 1 }
    var $max_div_exp { value = $max_num / $exp }

    // Process each digit position
    while ($max_div_exp > 0) {
      each {
        // Create 10 buckets (0-9)
        var $buckets { value = [[], [], [], [], [], [], [], [], [], []] }

        // Distribute numbers into buckets based on current digit
        foreach ($current_array) {
          each as $num {
            var $div_result { value = $num / $exp }
            var $digit { value = $div_result % 10 }
            var $bucket_index { value = $digit }
            
            // Get the current bucket and append to it
            var $bucket { value = $buckets[$bucket_index] }
            var $new_bucket { value = $bucket|push:$num }
            var.update $buckets[$bucket_index] { value = $new_bucket }
          }
        }

        // Collect numbers from buckets back into array
        var $new_array { value = [] }
        var $bucket_idx { value = 0 }
        while ($bucket_idx < 10) {
          each {
            var $bucket { value = $buckets[$bucket_idx] }
            foreach ($bucket) {
              each as $num {
                var.update $new_array { value = $new_array|push:$num }
              }
            }
            var.update $bucket_idx { value = $bucket_idx + 1 }
          }
        }

        // Update current array and move to next digit position
        var.update $current_array { value = $new_array }
        var.update $exp { value = $exp * 10 }
        var.update $max_div_exp { value = $max_num / $exp }
      }
    }
  }
  response = $current_array
}
