function "shortest_distance_to_character" {
  description = "Find the shortest distance from each character in a string to a target character"
  input {
    text s { description = "The input string" }
    text c { description = "The target character to find (single character)" }
  }
  stack {
    // Get the length of the string
    var $len { value = ($input.s|strlen) }
    
    // Initialize result array with large numbers
    var $result { value = [] }
    
    // First pass: left to right - track distance from previous occurrence of c
    var $prev { value = -1 }
    
    for ($len) {
      each as $i {
        // Get character at position i
        var $char { value = ($input.s|substr:$i:($i + 1)) }
        
        conditional {
          if ($char == $input.c) {
            var.update $prev { value = $i }
            var $dist { value = 0 }
          }
          else {
            conditional {
              if ($prev == -1) {
                // No occurrence of c seen yet, use large number
                var $dist { value = $len }
              }
              else {
                var $dist { value = $i - $prev }
              }
            }
          }
        }
        
        // Append distance to result
        var.update $result {
          value = $result ~ [$dist]
        }
      }
    }
    
    // Second pass: right to left - minimize with distance from next occurrence of c
    var.update $prev { value = -1 }
    
    for ($len) {
      each as $j {
        // Calculate index from right: $len - 1 - $j
        var $i { value = ($len - 1) - $j }
        
        // Get character at position i
        var $char { value = ($input.s|substr:$i:($i + 1)) }
        
        conditional {
          if ($char == $input.c) {
            var.update $prev { value = $i }
          }
          else {
            conditional {
              if ($prev != -1) {
                // Calculate distance from right
                var $dist_from_right { value = $prev - $i }
                // Get current value at position i
                var $current { value = ($result|get:$i) }
                // Take minimum
                conditional {
                  if ($dist_from_right < $current) {
                    // Update result at position i
                    var $before { value = ($result|slice:0:$i) }
                    var $after { value = ($result|slice:($i + 1):$len) }
                    var.update $result { value = $before ~ [$dist_from_right] ~ $after }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  response = $result
}
