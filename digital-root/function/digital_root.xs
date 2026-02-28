function "digital_root" {
  description = "Calculate the digital root of a number (recursive sum of digits until single digit)"
  input {
    int n filters=min:0 { description = "Non-negative integer to find digital root of" }
  }
  stack {
    // Digital root has a mathematical formula: 1 + (n - 1) % 9
    // This works for all positive numbers. For 0, digital root is 0.
    conditional {
      if ($input.n == 0) {
        var $result { value = 0 }
      }
      else {
        var $result { value = 1 + (($input.n - 1) | modulus:9) }
      }
    }
  }
  response = $result
}
