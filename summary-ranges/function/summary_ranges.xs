// Summary Ranges - Given a sorted unique array, return compact range representations
// Example: [0,1,2,4,5,7] -> ["0->2", "4->5", "7"]
function "summary_ranges" {
  description = "Converts a sorted unique integer array into compact range strings"
  
  input {
    int[] nums { description = "Sorted array of unique integers" }
  }
  
  stack {
    var $result { value = [] }
    var $n { value = $input.nums|count }
    var $i { value = 0 }
    
    // Process array only if not empty
    while ($i < $n) {
      each {
        // Start of current range
        var $start { value = $input.nums[$i] }
        var $end { value = $start }
        
        // Extend range while consecutive
        while (($i + 1 < $n) && ($input.nums[$i + 1] == $end + 1)) {
          each {
            var $end { value = $input.nums[$i + 1] }
            math.add $i { value = 1 }
          }
        }
        
        // Format the range
        conditional {
          if ($start == $end) {
            // Single number
            var $range_str { value = $start|to_text }
          }
          else {
            // Range with arrow
            var $range_str { value = ($start|to_text) ~ "->" ~ ($end|to_text) }
          }
        }
        
        // Add to result
        array.push $result {
          value = $range_str
        }
        
        math.add $i { value = 1 }
      }
    }
  }
  
  response = $result
}
