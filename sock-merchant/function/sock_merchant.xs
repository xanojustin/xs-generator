function "sock_merchant" {
  description = "Count the number of matching pairs of socks from an array of sock colors"
  input {
    int[] socks { description = "Array of integers representing sock colors" }
  }
  stack {
    // Create a frequency map to count occurrences of each color
    var $frequency_map { value = {} }
    
    foreach ($input.socks) {
      each as $sock {
        // Get current count for this color, default to 0
        var $current_count { value = $frequency_map|get:$sock|to_int }
        
        // Increment count
        var $new_count { value = $current_count + 1 }
        
        // Update the frequency map
        var.update $frequency_map { value = $frequency_map|set:$sock:$new_count }
      }
    }
    
    // Count pairs from the frequency map
    var $total_pairs { value = 0 }
    
    // Get all values from the frequency map (the counts)
    var $counts { value = $frequency_map|values }
    
    foreach ($counts) {
      each as $count {
        // Integer division to get number of pairs
        var $pairs { value = $count / 2 }
        var.update $total_pairs { value = $total_pairs + $pairs }
      }
    }
  }
  response = $total_pairs
}
