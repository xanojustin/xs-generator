// Sort Array By Parity II
// Given an array of integers nums (half even, half odd), rearrange so that:
// - nums[i] is even when i is even
// - nums[i] is odd when i is odd
function "sort_by_parity_ii" {
  description = "Sorts array so even indices have even numbers and odd indices have odd numbers"
  
  input {
    int[] nums { description = "Array with equal number of even and odd integers" }
  }
  
  stack {
    // Separate even and odd numbers
    var $even_nums { value = [] }
    var $odd_nums { value = [] }
    
    foreach ($input.nums) {
      each as $num {
        conditional {
          if (`$num % 2 == 0`) {
            var $even_nums { value = $even_nums|merge:[$num] }
          }
          else {
            var $odd_nums { value = $odd_nums|merge:[$num] }
          }
        }
      }
    }
    
    // Build result array with evens at even indices, odds at odd indices
    var $result { value = [] }
    var $even_idx { value = 0 }
    var $odd_idx { value = 0 }
    var $i { value = 0 }
    
    while ($i < ($input.nums|count)) {
      each {
        conditional {
          if (`$i % 2 == 0`) {
            // Even index - place even number
            var $even_val { value = $even_nums|get:$even_idx }
            var $result { value = $result|merge:[$even_val] }
            var $even_idx { value = $even_idx + 1 }
          }
          else {
            // Odd index - place odd number
            var $odd_val { value = $odd_nums|get:$odd_idx }
            var $result { value = $result|merge:[$odd_val] }
            var $odd_idx { value = $odd_idx + 1 }
          }
        }
        var $i { value = $i + 1 }
      }
    }
  }
  
  response = $result
}
