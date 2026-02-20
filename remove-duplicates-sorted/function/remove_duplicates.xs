function "remove_duplicates" {
  description = "Remove duplicates from a sorted array in-place and return the new length"
  input {
    int[] nums { description = "Sorted array of integers" }
  }
  stack {
    var $n { value = $input.nums|count }
    var $result_length { value = $n }
    var $nums_copy { value = $input.nums }
    
    conditional {
      if ($n > 1) {
        var $write_index { value = 1 }
        
        for ($n - 1) {
          each as $i {
            var $read_index { value = $i + 1 }
            var $current { value = $input.nums[$read_index] }
            var $previous { value = $input.nums[$read_index - 1] }
            
            conditional {
              if ($current != $previous) {
                var.update $nums_copy[$write_index] { value = $current }
                math.add $write_index { value = 1 }
              }
            }
          }
        }
        
        var.update $result_length { value = $write_index }
      }
    }
  }
  response = $result_length
}
