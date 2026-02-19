function "palindrome_check" {
  description = "Check if a string is a palindrome, ignoring case, spaces, and non-alphanumeric characters"
  input {
    text text filters=max:1000 {
      description = "The string to check for palindrome properties"
    }
  }
  stack {
    // Convert to lowercase
    var $lowercase {
      value = $input.text|to_lower
    }

    // Remove all non-alphanumeric characters using regex
    var $cleaned {
      value = "/[^a-z0-9]/"|regex_replace:"":$lowercase
    }

    // Reverse the cleaned string
    var $reversed {
      value = $cleaned|split:""|reverse|join:""
    }

    // Compare cleaned string with its reverse
    conditional {
      if ($cleaned == $reversed) {
        var $result { value = true }
      }
      else {
        var $result { value = false }
      }
    }
  }
  response = $result
}
