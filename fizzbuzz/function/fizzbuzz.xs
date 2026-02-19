function "fizzbuzz" {
  description = "Generate FizzBuzz sequence up to n - returns array where multiples of 3 are 'Fizz', multiples of 5 are 'Buzz', multiples of both are 'FizzBuzz'"
  
  input {
    int n {
      description = "The upper limit of the sequence (inclusive)"
    }
  }
  
  stack {
    // Handle edge case: n less than 1
    conditional {
      if ($input.n < 1) {
        return { value = [] }
      }
    }
    
    // Initialize result array
    var $result {
      value = []
    }
    
    // Loop from 1 to n (inclusive)
    foreach ((1..$input.n)) {
      each as $i {
        // Check divisibility
        var $divisible_by_3 {
          value = ($i % 3) == 0
        }
        var $divisible_by_5 {
          value = ($i % 5) == 0
        }
        
        conditional {
          // FizzBuzz case: divisible by both 3 and 5
          if ($divisible_by_3 && $divisible_by_5) {
            var $result {
              value = $result|push:"FizzBuzz"
            }
          }
          // Fizz case: divisible by 3 only
          elseif ($divisible_by_3) {
            var $result {
              value = $result|push:"Fizz"
            }
          }
          // Buzz case: divisible by 5 only
          elseif ($divisible_by_5) {
            var $result {
              value = $result|push:"Buzz"
            }
          }
          // Number case: not divisible by 3 or 5
          else {
            var $result {
              value = $result|push:($i|to_text)
            }
          }
        }
      }
    }
  }
  
  response = $result
}
