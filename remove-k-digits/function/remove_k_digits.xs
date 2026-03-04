function "remove_k_digits" {
  description = "Remove k digits from a number string to form the smallest possible integer using a greedy stack approach"
  
  input {
    text num { description = "The number string from which to remove digits" }
    int k { description = "Number of digits to remove" }
  }
  
  stack {
    // Handle edge case: if k equals string length, return "0"
    conditional {
      if (($input.num|strlen) == $input.k) {
        return { value = "0" }
      }
    }
    
    // Initialize an empty stack (array to hold digits)
    var $stack { value = [] }
    
    // Split the number string into individual characters
    var $digits { value = $input.num|split:"" }
    
    // Track remaining digits we can remove
    var $remaining_k { value = $input.k }
    
    // Iterate through each digit
    foreach ($digits) {
      each as $digit {
        // While we can still remove digits and the top of stack is greater than current digit
        // Remove the larger digit (greedy: smaller digits on left = smaller number)
        while ((($stack|count) > 0) && ($remaining_k > 0) && (($stack|last) > $digit)) {
          each {
            // Pop from stack
            var $new_stack { value = $stack|slice:0:-1 }
            var.update $stack { value = $new_stack }
            // Decrement remaining_k
            var.update $remaining_k { value = $remaining_k - 1 }
          }
        }
        
        // Push current digit onto stack
        var $new_stack { value = $stack|push:$digit }
        var.update $stack { value = $new_stack }
      }
    }
    
    // If we still have digits to remove, remove from the end
    conditional {
      if ($remaining_k > 0) {
        var $end_index { value = ($stack|count) - $remaining_k }
        var $final_stack { value = $stack|slice:0:$end_index }
        var.update $stack { value = $final_stack }
      }
    }
    
    // Join the stack and remove leading zeros
    var $result { value = $stack|join:"" }
    var $result_no_leading { value = $result|ltrim:"0" }
    
    // Handle case where result is empty (all zeros removed)
    conditional {
      if (($result_no_leading|strlen) == 0) {
        return { value = "0" }
      }
    }
  }
  
  response = $result_no_leading
}
