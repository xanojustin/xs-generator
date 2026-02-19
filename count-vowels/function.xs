function "count_vowels" {
  description = "Count the number of vowels in a given string"
  input {
    text str filters=trim {
      description = "The string to count vowels in"
    }
  }
  stack {
    // Convert to lowercase for case-insensitive counting
    var $lowercase {
      value = $input.str|to_lower
    }

    // Remove all non-vowel characters using regex, leaving only a, e, i, o, u
    var $vowels_only {
      value = "/[^aeiou]/"|regex_replace:"":$lowercase
    }

    // The length of the resulting string is the vowel count
    var $count {
      value = $vowels_only|count
    }
  }
  response = $count
}
