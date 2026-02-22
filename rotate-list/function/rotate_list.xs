// Rotate List - Rotate a linked list to the right by k places
// Uses array representation for the linked list
function "rotate_list" {
  description = "Rotates a linked list to the right by k places"

  input {
    int[] head { description = "Array representing the linked list values" }
    int k { description = "Number of places to rotate right" }
  }

  stack {
    // Handle edge cases
    var $length { value = $input.head|count }
    
    conditional {
      if ($length <= 1) {
        var $result { value = $input.head }
      }
      elseif ($input.k <= 0) {
        var $result { value = $input.head }
      }
      else {
        // Calculate effective rotation (k may be larger than length)
        var $effective_k { value = $input.k % $length }
        
        conditional {
          if ($effective_k == 0) {
            var $result { value = $input.head }
          }
          else {
            // Split point: elements from (length - k) to end go to front
            var $split_point { value = $length - $effective_k }
            
            // Get the second part (elements from split_point to end)
            var $second_part { value = [] }
            var $i { value = $split_point }
            
            while ($i < $length) {
              each {
                var $second_part { value = $second_part|merge:[$input.head[$i]] }
                var.update $i { value = $i + 1 }
              }
            }
            
            // Get the first part (elements from 0 to split_point)
            var $first_part { value = [] }
            var $j { value = 0 }
            
            while ($j < $split_point) {
              each {
                var $first_part { value = $first_part|merge:[$input.head[$j]] }
                var.update $j { value = $j + 1 }
              }
            }
            
            // Concatenate: second_part + first_part
            var $result { value = $second_part|merge:$first_part }
          }
        }
      }
    }
  }

  response = $result
}
