// String Compression - Classic coding exercise
// Compresses a string using counts of repeated characters
// Example: "aaabbc" -> "a3b2c1"
function "string-compression" {
  description = "Compresses a string using counts of repeated characters"

  input {
    text str { description = "The input string to compress" }
  }

  stack {
    // Handle empty string edge case
    conditional {
      if (`$input.str|strlen == 0`) {
        return { value = "" }
      }
    }

    // Initialize variables for compression
    var $compressed { value = "" }
    var $current_char { value = $input.str|substr:0:1 }
    var $count { value = 1 }
    var $i { value = 1 }

    // Loop through the string starting from second character
    while ($i < $input.str|strlen) {
      each {
        var $char { value = $input.str|substr:$i:1 }

        conditional {
          // Same character - increment count
          if (`$char == $current_char`) {
            var.update $count { value = $count + 1 }
          }
          // Different character - append previous group and reset
          else {
            var $compressed {
              value = $compressed ~ $current_char ~ ($count|to_text)
            }
            var.update $current_char { value = $char }
            var.update $count { value = 1 }
          }
        }

        var.update $i { value = $i + 1 }
      }
    }

    // Append the final character group
    var $compressed {
      value = $compressed ~ $current_char ~ ($count|to_text)
    }

    return { value = $compressed }
  }

  response = $output
}
