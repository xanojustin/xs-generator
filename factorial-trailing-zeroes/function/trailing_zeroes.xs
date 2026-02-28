function "trailing_zeroes" {
  description = "Count the number of trailing zeroes in n factorial (n!)"
  input {
    int n filters=min:0
  }
  stack {
    // Edge case: 0! = 1, which has 0 trailing zeroes
    conditional {
      if ($input.n == 0) {
        return { value = 0 }
      }
    }

    // Count factors of 5 using Legendre's formula
    // Trailing zeroes = n/5 + n/25 + n/125 + n/625 + ...
    var $count { value = 0 }
    var $divisor { value = 5 }

    while ($divisor <= $input.n) {
      each {
        var $addition { value = ($input.n / $divisor)|to_int }
        var.update $count { value = $count + $addition }
        var.update $divisor { value = $divisor * 5 }
      }
    }
  }
  response = $count
}
