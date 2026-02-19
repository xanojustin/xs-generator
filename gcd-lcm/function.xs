function "gcd_lcm" {
  description = "Calculate GCD and LCM of two integers"
  input {
    int a {
      description = "First integer (can be negative, zero, or positive)"
    }
    int b {
      description = "Second integer (can be negative, zero, or positive)"
    }
  }
  stack {
    // Handle edge case where both inputs are zero
    // GCD(0, 0) is undefined, but we'll return 0 for both
    conditional {
      if ($input.a == 0 && $input.b == 0) {
        var $result {
          value = {
            gcd: 0
            lcm: 0
          }
        }
      }
      else {
        // Calculate absolute values for GCD computation
        conditional {
          if ($input.a < 0) {
            var $abs_a { value = 0 - $input.a }
          }
          else {
            var $abs_a { value = $input.a }
          }
        }
        
        conditional {
          if ($input.b < 0) {
            var $abs_b { value = 0 - $input.b }
          }
          else {
            var $abs_b { value = $input.b }
          }
        }
        
        // Calculate GCD using Euclidean algorithm
        var $x { value = $abs_a }
        var $y { value = $abs_b }
        
        while ($y != 0) {
          each {
            var $temp { value = $y }
            var.update $y { value = $x % $y }
            var.update $x { value = $temp }
          }
        }
        
        var $gcd_result { value = $x }
        
        // Calculate LCM: LCM(a, b) = |a * b| / GCD(a, b)
        // If either number is 0, LCM is 0
        conditional {
          if ($input.a == 0 || $input.b == 0) {
            var $lcm_result { value = 0 }
          }
          else {
            var $product { value = $abs_a * $abs_b }
            var $lcm_result { value = $product / $gcd_result }
          }
        }
        
        var $result {
          value = {
            gcd: $gcd_result
            lcm: $lcm_result
          }
        }
      }
    }
  }
  response = $result
}
