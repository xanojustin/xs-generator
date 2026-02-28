function "max_product_of_three" {
  description = "Given an integer array, find three numbers whose product is maximum and return the maximum product."
  input {
    int[] nums { description = "Array of integers" }
  }
  stack {
    // Sort the array in ascending order
    var $sorted { value = $input.nums|sort }
    
    // Get the length of the array
    var $n { value = $sorted|count }
    
    // Calculate product of three largest numbers
    var $product1 { 
      value = ($sorted|index:($n - 1)) * ($sorted|index:($n - 2)) * ($sorted|index:($n - 3))
    }
    
    // Calculate product of two smallest (could be negative) and largest
    var $product2 { 
      value = ($sorted|index:0) * ($sorted|index:1) * ($sorted|index:($n - 1))
    }
    
    // Return the maximum of the two products
    conditional {
      if ($product1 > $product2) {
        var $result { value = $product1 }
      }
      else {
        var $result { value = $product2 }
      }
    }
  }
  response = $result
}
