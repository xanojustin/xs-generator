// Plus Minus - Calculate ratios of positive, negative, and zero elements
// Given an array of integers, calculate the ratios of positive, negative,
// and zero elements. Print the ratios as decimal values.
function "plus-minus" {
  description = "Calculate ratios of positive, negative, and zero elements in an array"
  
  input {
    int[] arr { description = "Array of integers to analyze" }
  }
  
  stack {
    var $positive_count { value = 0 }
    var $negative_count { value = 0 }
    var $zero_count { value = 0 }
    var $total { value = $input.arr|count }
    
    foreach ($input.arr) {
      each as $num {
        conditional {
          if ($num > 0) {
            var.update $positive_count { value = $positive_count + 1 }
          }
          elseif ($num < 0) {
            var.update $negative_count { value = $negative_count + 1 }
          }
          else {
            var.update $zero_count { value = $zero_count + 1 }
          }
        }
      }
    }
    
    // Calculate ratios with 6 decimal places
    var $positive_ratio {
      value = ($total > 0) ? ($positive_count / $total) : 0
    }
    var $negative_ratio {
      value = ($total > 0) ? ($negative_count / $total) : 0
    }
    var $zero_ratio {
      value = ($total > 0) ? ($zero_count / $total) : 0
    }
  }
  
  response = {
    positive_ratio: $positive_ratio
    negative_ratio: $negative_ratio
    zero_ratio: $zero_ratio
    positive_count: $positive_count
    negative_count: $negative_count
    zero_count: $zero_count
    total: $total
  }
}
