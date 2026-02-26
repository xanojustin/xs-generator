function "concatenation_of_array" {
  description = "Return the concatenation of the input array with itself"
  input {
    int[] nums
  }
  stack {
    var $result {
      value = []
    }
    
    // Add first copy of array
    foreach ($input.nums) {
      each as $num {
        var.update $result {
          value = $result ~ [$num]
        }
      }
    }
    
    // Add second copy of array
    foreach ($input.nums) {
      each as $num {
        var.update $result {
          value = $result ~ [$num]
        }
      }
    }
  }
  response = $result
}
