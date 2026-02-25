function "sort_by_parity" {
  description = "Sort array by parity - even numbers first, then odd numbers"
  input {
    int[] nums
  }
  stack {
    var $evens { value = [] }
    var $odds { value = [] }
    
    foreach ($input.nums) {
      each as $num {
        conditional {
          if (($num % 2) == 0) {
            var.update $evens { value = $evens|append:$num }
          }
          else {
            var.update $odds { value = $odds|append:$num }
          }
        }
      }
    }
    
    var $result { value = $evens|merge:$odds }
  }
  response = $result
}
