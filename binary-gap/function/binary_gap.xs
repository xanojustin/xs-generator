function "binary_gap" {
  description = "Find the longest binary gap in the binary representation of a positive integer"
  input {
    int n filters=min:1
  }
  stack {
    // Convert the number to its binary representation as text
    var $binary {
      value = $input.n|to_text:2
    }
    
    // Initialize variables to track the maximum gap and current gap
    var $max_gap {
      value = 0
    }
    var $current_gap {
      value = 0
    }
    var $found_one {
      value = false
    }
    
    // Iterate through each character in the binary string
    foreach ($binary|split:"") {
      each as $char {
        conditional {
          if ($char == "1") {
            // If we found a 1 and had already found a previous 1,
            // check if current gap is the maximum
            conditional {
              if ($found_one) {
                conditional {
                  if ($current_gap > $max_gap) {
                    var.update $max_gap {
                      value = $current_gap
                    }
                  }
                }
              }
            }
            // Reset current gap and mark that we found a 1
            var.update $current_gap {
              value = 0
            }
            var.update $found_one {
              value = true
            }
          }
          else {
            // If we found a 0 and have already seen a 1,
            // increment the current gap
            conditional {
              if ($found_one) {
                var.update $current_gap {
                  value = $current_gap + 1
                }
              }
            }
          }
        }
      }
    }
  }
  response = $max_gap
}
