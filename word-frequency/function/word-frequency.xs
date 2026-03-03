// Word Frequency Counter
// Counts the frequency of each word in a given text
function "word-frequency" {
  description = "Counts the frequency of each word in a text"

  input {
    text text { description = "The input text to analyze" }
  }

  stack {
    // Normalize the text: lowercase and split into words
    var $normalized {
      value = $input.text|to_lower
    }

    // Split text into words by whitespace
    var $words_array {
      value = $normalized|split:" "
    }

    // Filter out empty strings from multiple spaces
    var $words {
      value = $words_array|filter:($$|strlen) > 0
    }

    // Initialize frequency object
    var $frequency {
      value = {}
    }

    // Count each word
    foreach ($words) {
      each as $word {
        // Check if word already exists in frequency object
        conditional {
          if ($frequency|has:$word) {
            // Increment count
            var $current_count {
              value = $frequency|get:$word
            }
            var $new_count {
              value = $current_count + 1
            }
            var $frequency {
              value = $frequency|set:$word:$new_count
            }
          }
          else {
            // First occurrence
            var $frequency {
              value = $frequency|set:$word:1
            }
          }
        }
      }
    }

    // Convert to entries array
    var $word_entries {
      value = $frequency|entries
    }
  }

  response = {
    total_words: ($words|count),
    unique_words: ($frequency|keys|count),
    frequencies: $word_entries
  }
}
