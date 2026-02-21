function "remove_element" {
  description = "Remove all instances of a value from array in-place and return new length"
  input {
    int[] nums
    int val
  }
  stack {
    conditional {
      if (($input.nums|count) == 0) {
        return { value = 0 }
      }
    }
    var $working_nums {
      value = $input.nums
    }
    var $write {
      value = 0
    }
    foreach ($input.nums) {
      each as $num {
        conditional {
          if ($num != $input.val) {
            var.update $working_nums[$write] { value = $num }
            var.update $write { value = $write + 1 }
          }
        }
      }
    }
  }
  response = $write
}
