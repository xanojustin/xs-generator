function "build_array" {
  description = "Builds an array from permutation where ans[i] = nums[nums[i]]"
  input {
    int[] nums
  }
  stack {
    var $result {
      value = []
    }
    
    foreach ((0..(($input.nums|count) - 1))) {
      each as $i {
        var $index {
          value = $input.nums[$i]
        }
        var $value {
          value = $input.nums[$index]
        }
        array.push $result {
          value = $value
        }
      }
    }
  }
  response = $result
}
