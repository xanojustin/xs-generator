// Find Duplicates - Returns all elements that appear more than once in the input array
function "find_duplicates" {
  description = "Finds all duplicate elements in an integer array"
  
  input {
    int[] numbers { description = "Array of integers to check for duplicates" }
  }
  
  stack {
    // Use a frequency map approach: track count of each number
    var $frequency { value = {} }
    var $duplicates { value = [] }
    var $i { value = 0 }
    var $len { value = $input.numbers|count }
    
    // Count frequency of each number
    while ($i < $len) {
      each {
        var $num { value = $input.numbers[$i] }
        var $num_text { value = $num|to_text }
        var $current_count { 
          value = $frequency|get:$num_text:0 
        }
        var $new_count { value = $current_count + 1 }
        
        // Update frequency map
        var $frequency { 
          value = $frequency|merge:{$num_text: $new_count} 
        }
        
        var.update $i { value = $i + 1 }
      }
    }
    
    // Reset for second pass to collect duplicates
    var $i { value = 0 }
    var $processed { value = {} }
    
    // Collect numbers that appear more than once (only add each duplicate once)
    while ($i < $len) {
      each {
        var $num { value = $input.numbers[$i] }
        var $num_text { value = $num|to_text }
        var $count { value = $frequency|get:$num_text:0 }
        var $already_added { value = $processed|get:$num_text:false }
        
        conditional {
          if ($count > 1 && !$already_added) {
            // This is a duplicate we haven't added yet
            array.push $duplicates {
              value = $num
            }
            var $processed {
              value = $processed|merge:{$num_text: true}
            }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $duplicates
}
