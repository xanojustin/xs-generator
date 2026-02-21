function "move_zeros" {
  description = "Move all zeros to the end of an array while maintaining the relative order of non-zero elements"
  input {
    int[] nums { description = "Array of integers to process" }
  }
  stack {
    // Create a local reference to the input array
    var $nums {
      value = $input.nums
    }
    
    // Filter out zeros to get non-zero elements (maintains order)
    array.filter ($nums) if ($this != 0) as $non_zeros
    
    // Count how many zeros we need to add
    var $zero_count {
      value = ($nums|count) - ($non_zeros|count)
    }
    
    // Create an array of zeros using fill filter
    var $zeros {
      value = []|fill:$zero_count:0
    }
    
    // Merge non-zeros with zeros
    var $result {
      value = $non_zeros|merge:$zeros
    }
  }
  response = $result
}
