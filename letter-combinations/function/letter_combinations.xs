function "letter_combinations" {
  description = "Generate all possible letter combinations from a phone number digit string"
  input {
    text digits filters=trim { description = "String of digits 2-9 (e.g., '23')" }
  }
  stack {
    // Define phone keypad mapping
    var $keypad {
      value = {
        "2": ["a", "b", "c"],
        "3": ["d", "e", "f"],
        "4": ["g", "h", "i"],
        "5": ["j", "k", "l"],
        "6": ["m", "n", "o"],
        "7": ["p", "q", "r", "s"],
        "8": ["t", "u", "v"],
        "9": ["w", "x", "y", "z"]
      }
    }

    // Handle empty input - set result to empty array
    var $result { value = [] }
    conditional {
      if (($input.digits|strlen) == 0) {
        var $result { value = [] }
      }
      else {
        // Get the letters for each digit
        var $digit_letters { value = [] }
        for (($input.digits|strlen)) {
          each as $i {
            var $digit {
              value = $input.digits|substr:$i:1
            }
            var $letters {
              value = $keypad|get:($digit)
            }
            var $digit_letters {
              value = $digit_letters|set:(($digit_letters|count)|to_text):($letters)
            }
          }
        }

        // Build combinations iteratively using a queue-like approach
        // Start with empty string
        var $queue { value = [""] }

        foreach ($digit_letters) {
          each as $letters {
            var $new_queue { value = [] }
            foreach ($queue) {
              each as $prefix {
                foreach ($letters) {
                  each as $letter {
                    var $new_queue {
                      value = $new_queue|set:(($new_queue|count)|to_text):($prefix ~ $letter)
                    }
                  }
                }
              }
            }
            var $queue { value = $new_queue }
          }
        }

        var $result { value = $queue }
      }
    }
  }
  response = $result
}
