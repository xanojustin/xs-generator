function "gcd_lcm" {
  description = "Calculate GCD and LCM of two positive integers"
  input {
    int a filters=min:1 { description = "First positive integer" }
    int b filters=min:1 { description = "Second positive integer" }
  }
  stack {
    // Store original values for LCM calculation
    var $original_a { value = $input.a }
    var $original_b { value = $input.b }

    // Calculate GCD using Euclidean algorithm
    var $x { value = $input.a }
    var $y { value = $input.b }

    while ($y != 0) {
      each {
        var $temp { value = $y }
        var.update $y { value = $x % $y }
        var.update $x { value = $temp }
      }
    }

    var $gcd { value = $x }

    // Calculate LCM using the formula: LCM(a, b) = (a * b) / GCD(a, b)
    var $lcm { value = ($original_a * $original_b) / $gcd }

    // Build the result object
    var $result {
      value = {
        gcd: $gcd,
        lcm: $lcm,
        a: $original_a,
        b: $original_b
      }
    }
  }
  response = $result
}
