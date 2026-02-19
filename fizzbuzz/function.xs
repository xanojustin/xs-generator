function "fizzbuzz" {
  description = "Generate FizzBuzz sequence up to n"
  input {
    int n filters=min:1|max:10000 {
      description = "The upper limit of the sequence (must be >= 1)"
    }
  }
  stack {
    var $result { value = [] }
    var $i { value = 1 }

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
            var $item { value = $i|to_text }
          }
        }

        var.update $result { value = $result|push:$item }
        var.update $i { value = $i + 1 }
      }
    }
  }
  response = $result
}
