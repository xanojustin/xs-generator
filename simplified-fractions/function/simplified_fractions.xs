function "simplified_fractions" {
  description = "Returns all simplified fractions between 0 and 1 with denominators from 2 to n"
  input {
    int n { description = "Maximum denominator (must be >= 2)" }
  }
  stack {
    // Validate input
    precondition ($input.n >= 2) {
      error_type = "inputerror"
      error = "n must be at least 2"
    }

    // Initialize result array
    var $fractions { value = [] }

    // Iterate through all possible denominators from 2 to n
    var $d { value = 2 }
    while ($d <= $input.n) {
      each {
        // Iterate through all possible numerators from 1 to d-1
        var $numerator { value = 1 }
        while ($numerator < $d) {
          each {
            // Calculate GCD using Euclidean algorithm
            var $a { value = $numerator }
            var $b { value = $d }

            // Euclidean algorithm to find GCD
            while ($b != 0) {
              each {
                var $temp { value = $b }
                var.update $b { value = $a % $b }
                var.update $a { value = $temp }
              }
            }

            var $gcd { value = $a }

            // If GCD is 1, the fraction is simplified
            conditional {
              if ($gcd == 1) {
                // Format as "numerator/denominator"
                var $fraction_str { value = ($numerator|to_text) ~ "/" ~ ($d|to_text) }
                array.push $fractions { value = $fraction_str }
              }
            }

            var.update $numerator { value = $numerator + 1 }
          }
        }

        var.update $d { value = $d + 1 }
      }
    }
  }
  response = $fractions
}
