function "smallest_even_multiple" {
  description = "Find the smallest even multiple of a given positive integer n"
  input {
    int n filters=min:1 { description = "A positive integer" }
  }
  stack {
    // Check if n is already even (divisible by 2)
    conditional {
      if ($input.n % 2 == 0) {
        // n is even, so it's its own smallest even multiple
        var $result { value = $input.n }
      }
      else {
        // n is odd, so multiply by 2 to get the smallest even multiple
        var $result { value = $input.n * 2 }
      }
    }
  }
  response = $result
}
