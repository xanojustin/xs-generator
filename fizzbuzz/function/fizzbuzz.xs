function "fizzbuzz" {
  description = "Generate FizzBuzz sequence up to n. Returns 'Fizz' for multiples of 3, 'Buzz' for multiples of 5, 'FizzBuzz' for multiples of both, and the number itself otherwise."
  
  input {
    int n
  }
  
  stack {
    // Initialize empty array to store results
    var $result { value = [] }
    
    // Initialize counter
    var $i { value = 1 }
    
    // Loop from 1 to n
    while ($i <= $input.n) {
      each {
        conditional {
          if ($i % 15 == 0) {
            var $item { value = "FizzBuzz" }
          }
          elseif ($i % 3 == 0) {
            var $item { value = "Fizz" }
          }
          elseif ($i % 5 == 0) {
            var $item { value = "Buzz" }
          }
          else {
            var $item { value = $i }
          }
        }
        
        // Append item to result array
        var $result { value = $result|merge:[$item] }
        
        // Increment counter
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $result
}
