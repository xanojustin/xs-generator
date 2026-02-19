// FizzBuzz - Classic coding exercise
// Returns "Fizz" for multiples of 3, "Buzz" for multiples of 5,
// "FizzBuzz" for multiples of both, or the number itself
function "fizzbuzz" {
  description = "Generates FizzBuzz sequence up to n"
  
  input {
    int n { description = "Upper limit of the sequence (inclusive)" }
  }
  
  stack {
    var $results { value = [] }
    var $i { value = 1 }
    
    while ($i <= $input.n) {
      each {
        conditional {
          if (`$i % 15 == 0`) {
            var $item { value = "FizzBuzz" }
          }
          elseif (`$i % 3 == 0`) {
            var $item { value = "Fizz" }
          }
          elseif (`$i % 5 == 0`) {
            var $item { value = "Buzz" }
          }
          else {
            var $item { value = $i|to_text }
          }
        }
        
        var $results { 
          value = $results|merge:[$item]
        }
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = $results
}
