function "product_of_array_except_self" {
  description = "Given an integer array, return an array where each element is the product of all other elements (without using division)"
  input {
    int[] nums {
      description = "Array of integers (minimum 2 elements)"
    }
  }
  stack {
    // Validate input: need at least 2 elements
    precondition (($input.nums|count) >= 2) {
      error_type = "standard"
      error = "Input array must contain at least 2 elements"
    }
    
    var $n { value = $input.nums|count }
    var $result { value = [] }
    
    // Initialize result array with 1s
    var $k { value = 0 }
    while ($k < $n) {
      each {
        var $result {
          value = $result|push:1
        }
        var.update $k { value = $k + 1 }
      }
    }
    
    // First pass: left to right
    // result[i] contains product of all elements to the left of i
    var $left_product { value = 1 }
    var $i { value = 0 }
    
    while ($i < $n) {
      each {
        // Set result[i] to the product of all elements to its left
        var $result {
          value = $result|set:$i:$left_product
        }
        // Update left_product to include nums[i] for next iteration
        var.update $left_product {
          value = $left_product * ($input.nums|get:$i)
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Second pass: right to left
    // Multiply result[i] by product of all elements to the right of i
    var $right_product { value = 1 }
    var $j { value = $n - 1 }
    
    while ($j >= 0) {
      each {
        // Multiply result[j] by the product of all elements to its right
        var $current_value {
          value = ($result|get:$j) * $right_product
        }
        var $result {
          value = $result|set:$j:$current_value
        }
        // Update right_product to include nums[j] for next iteration
        var.update $right_product {
          value = $right_product * ($input.nums|get:$j)
        }
        var.update $j { value = $j - 1 }
      }
    }
  }
  response = $result
}
