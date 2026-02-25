function "bulls_and_cows" {
  input {
    text secret
    text guess
  }
  stack {
    // Validate inputs are same length
    precondition (($input.secret|strlen) == ($input.guess|strlen)) {
      error_type = "inputerror"
      error = "Secret and guess must be same length"
    }

    var $bulls { value = 0 }
    var $cows { value = 0 }
    var $secret_chars { value = $input.secret|split:"" }
    var $guess_chars { value = $input.guess|split:"" }
    var $secret_length { value = $input.secret|strlen }
    var $used_secret { value = [] }
    var $used_guess { value = [] }

    // First pass: count bulls (exact matches)
    var $i { value = 0 }
    while ($i < $secret_length) {
      each {
        conditional {
          if ($guess_chars[$i] == $secret_chars[$i]) {
            var.update $bulls { value = $bulls + 1 }
            var.update $used_secret { value = $used_secret|append:$i }
            var.update $used_guess { value = $used_guess|append:$i }
          }
        }
        var.update $i { value = $i + 1 }
      }
    }

    // Second pass: count cows (right digit, wrong position)
    var $j { value = 0 }
    while ($j < $secret_length) {
      each {
        // Skip if this guess position was already used (as a bull)
        conditional {
          if (!($used_guess|contains:$j)) {
            var $guess_digit { value = $guess_chars[$j] }
            var $k { value = 0 }
            var $found_cow { value = false }
            
            while ($k < $secret_length) {
              each {
                conditional {
                  if ((!($used_secret|contains:$k)) && $guess_digit == $secret_chars[$k] && (!($found_cow))) {
                    var.update $cows { value = $cows + 1 }
                    var.update $used_secret { value = $used_secret|append:$k }
                    var $found_cow { value = true }
                  }
                }
                var.update $k { value = $k + 1 }
              }
            }
          }
        }
        var.update $j { value = $j + 1 }
      }
    }
  }
  response = {
    bulls: $bulls,
    cows: $cows,
    hint: ($bulls|to_text) ~ "A" ~ ($cows|to_text) ~ "B"
  }
}
