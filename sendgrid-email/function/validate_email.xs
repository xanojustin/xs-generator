function "validate_email" {
  input {
    text email
  }
  stack {
    // Basic email validation using pattern matching
    // Check if email contains @ and has proper structure
    var $is_valid {
      value = false
    }

    // Check for @ symbol
    conditional {
      if ($input.email|contains:"@") {
        // Split by @ and check both parts exist
        var $parts {
          value = $input.email|split:"@"
        }

        conditional {
          if (($parts|count) >= 2) {
            var $local_part {
              value = $parts|first
            }
            var $domain_part {
              value = $parts|last
            }

            // Check local part and domain part are not empty
            conditional {
              if (($local_part|strlen) > 0 && ($domain_part|strlen) > 0) {
                // Check domain contains at least one dot
                conditional {
                  if ($domain_part|contains:".") {
                    var.update $is_valid {
                      value = true
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  response = {
    valid: $is_valid
    email: $input.email
  }
}
