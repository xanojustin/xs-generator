function "product-of-array-except-self" {
  description = "Given an integer array, return an array where each element is the product of all other elements except itself. Cannot use division."
  
  input {
    int[] numbers {
      description = "Array of integers"
    }
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
        return { value = [1] }
      }
    }
    
    var $n { value = $input.numbers|count }
    var $result { value = [] }
    var $left_product { value = 1 }
    var $right_product { value = 1 }
    var $i { value = 0 }
    
    // Initialize result array with 1s
    while ($i < $n) {
      each {
        var $result { value = $result ~ [1] }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Reset counter for left pass
    var.update $i { value = 0 }
    
    // Left pass: result[i] contains product of all elements to the left of i
    while ($i < $n) {
      each {
        // Update result at index i with current left_product
        var $left_val { value = $result|slice:0:$i }
        var $right_val { value = $result|slice:($i + 1):($n - $i - 1) }
        var $new_result { value = $left_val ~ [$left_product] ~ $right_val }
        var.update $result { value = $new_result }
        
        // Update left_product for next iteration
        var $current_num { value = $input.numbers|slice:$i:1 }
        var $current_val { value = $current_num|first }
        var.update $left_product { value = $left_product * $current_val }
        
        var.update $i { value = $i + 1 }
      }
    }
    
    // Reset for right pass
    var.update $i { value = $n - 1 }
    var.update $right_product { value = 1 }
    
    // Right pass: multiply result[i] by product of all elements to the right of i
    while ($i >= 0) {
      each {
        // Get current value at result[i] and multiply by right_product
        var $current_result { value = $result|slice:$i:1 }
        var $current_result_val { value = $current_result|first }
        var $new_val { value = $current_result_val * $right_product }
        
        // Update result at index i
        var $left_part { value = $result|slice:0:$i }
        var $right_part { value = $result|slice:($i + 1):($n - $i - 1) }
        var.update $result { value = $left_part ~ [$new_val] ~ $right_part }
        
        // Update right_product for next iteration
        var $current_num { value = $input.numbers|slice:$i:1 }
        var $current_val { value = $current_num|first }
        var.update $right_product { value = $right_product * $current_val }
        
        var.update $i { value = $i - 1 }
      }
    }
  }
  
  response = $result
}