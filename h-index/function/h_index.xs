function "h_index" {
  description = "Calculate the h-index for a researcher's citations"
  input {
    int[] citations
  }
  stack {
    // Handle empty array case
    conditional {
      if (($input.citations|count) == 0) {
        return { value = 0 }
      }
    }
    
    // Get total number of papers
    var $n { value = $input.citations|count }
    
    // Initialize h-index to 0
    var $h_index { value = 0 }
    
    // Try each possible h value from n down to 1
    // h-index is the largest h such that at least h papers have >= h citations
    var $h { value = $n }
    while ($h > 0) {
      each {
        // Count how many papers have at least $h citations
        var $count { value = 0 }
        
        var $i { value = 0 }
        while ($i < $n) {
          each {
            var $citation {
              value = $input.citations|get:$i
            }
            
            conditional {
              if ($citation >= $h) {
                var.update $count { value = $count + 1 }
              }
            }
            
            var.update $i { value = $i + 1 }
          }
        }
        
        // If at least h papers have >= h citations, we found our h-index
        conditional {
          if ($count >= $h) {
            var.update $h_index { value = $h }
            // Exit the outer while by setting h to 0
            var.update $h { value = 0 }
          }
        }
        
        // Decrement h for next iteration (if we haven't found the answer yet)
        conditional {
          if ($h > 0) {
            var.update $h { value = $h - 1 }
          }
        }
      }
    }
  }
  response = $h_index
}
