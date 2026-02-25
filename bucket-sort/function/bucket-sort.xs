function "bucket-sort" {
  description = "Sorts an array of decimal numbers using the bucket sort algorithm"
  
  input {
    decimal[] numbers { description = "Array of decimal numbers to sort" }
    int bucket_count?=10 { description = "Number of buckets to use (default: 10)" }
  }
  
  stack {
    // Handle edge case: empty array
    conditional {
      if (($input.numbers|count) == 0) {
        return { value = [] }
      }
    }
    
    // Handle edge case: single element
    conditional {
      if (($input.numbers|count) == 1) {
        return { value = $input.numbers }
      }
    }
    
    // Find min and max values to determine range
    var $min_val { value = $input.numbers|first }
    var $max_val { value = $input.numbers|first }
    
    var $i { value = 0 }
    while ($i < ($input.numbers|count)) {
      each {
        conditional {
          if ($input.numbers[$i] < $min_val) {
            var.update $min_val { value = $input.numbers[$i] }
          }
        }
        conditional {
          if ($input.numbers[$i] > $max_val) {
            var.update $max_val { value = $input.numbers[$i] }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Calculate range and bucket size
    var $range { value = $max_val - $min_val }
    
    // Handle case where all elements are the same
    conditional {
      if ($range == 0) {
        return { value = $input.numbers }
      }
    }
    
    var $bucket_size { value = $range / $input.bucket_count }
    
    // Initialize empty buckets
    var $buckets { value = [] }
    var $b { value = 0 }
    while ($b < $input.bucket_count) {
      each {
        var $empty_bucket { value = [] }
        var.update $buckets { value = $buckets ~ [$empty_bucket] }
        var.update $b { value = $b + 1 }
      }
    }
    
    // Distribute numbers into buckets
    var $j { value = 0 }
    while ($j < ($input.numbers|count)) {
      each {
        var $num { value = $input.numbers[$j] }
        var $bucket_index { value = (($num - $min_val) / $bucket_size)|to_int }
        
        // Handle edge case where number equals max (would be out of bounds)
        conditional {
          if ($bucket_index >= $input.bucket_count) {
            var.update $bucket_index { value = $input.bucket_count - 1 }
          }
        }
        
        // Add number to appropriate bucket
        var $target_bucket { value = $buckets[$bucket_index] }
        var.update $target_bucket { value = $target_bucket ~ [$num] }
        var.update $buckets[$bucket_index] { value = $target_bucket }
        
        var.update $j { value = $j + 1 }
      }
    }
    
    // Sort each bucket using insertion sort and merge results
    var $sorted_result { value = [] }
    
    var $k { value = 0 }
    while ($k < $input.bucket_count) {
      each {
        var $current_bucket { value = $buckets[$k] }
        
        conditional {
          if (($current_bucket|count) > 0) {
            // Sort the bucket using insertion sort
            var $m { value = 1 }
            while ($m < ($current_bucket|count)) {
              each {
                var $key { value = $current_bucket[$m] }
                var $n { value = $m - 1 }
                
                while ($n >= 0 && $current_bucket[$n] > $key) {
                  each {
                    var.update $current_bucket[$n + 1] { value = $current_bucket[$n] }
                    var.update $n { value = $n - 1 }
                  }
                }
                
                var.update $current_bucket[$n + 1] { value = $key }
                var.update $m { value = $m + 1 }
              }
            }
            
            // Append sorted bucket to result
            var $idx { value = 0 }
            while ($idx < ($current_bucket|count)) {
              each {
                var.update $sorted_result { value = $sorted_result ~ [$current_bucket[$idx]] }
                var.update $idx { value = $idx + 1 }
              }
            }
          }
        }
        
        var.update $k { value = $k + 1 }
      }
    }
  }
  
  response = $sorted_result
}
