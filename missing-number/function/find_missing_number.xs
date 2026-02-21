// Find Missing Number - Classic coding exercise
// Given an array containing n distinct numbers in range [0, n], 
// find the missing number using the mathematical sum formula
function "find_missing_number" {
  description = "Finds the missing number in a sequence from 0 to n"
  
  input {
    int[] nums { description = "Array of distinct integers from 0 to n with one missing" }
  }
  
  stack {
    // Calculate n from array length (array has n numbers, should have n+1)
    var $n { 
      value = $input.nums|count
    }
    
    // Expected sum of 0 to n is: n * (n + 1) / 2
    var $expected_sum {
      value = ($n * ($n + 1)) / 2
    }
    
    // Calculate actual sum of array elements
    var $actual_sum { value = 0 }
    var $i { value = 0 }
    
    while ($i < $n) {
      each {
        var $num { value = $input.nums[$i] }
        var.update $actual_sum {
          value = $actual_sum + $num
        }
        var.update $i { value = $i + 1 }
      }
    }
    
    // Missing number is the difference
    var $missing {
      value = $expected_sum - $actual_sum
    }
  }
  
  response = $missing
}
